import 'dart:math';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A file or folder of the tree, or, without an entity, the placeholder shown
/// while the folder at [path] loads, when it is empty or could not be read.
typedef FileTreeRow = ({
  FileSystemEntity<NoteFile>? entity,
  String path,
  int depth,
});

/// The tree layout of the files view: which folders are expanded, kept for the
/// session per storage, and the content of the folders read so far.
///
/// Reading a folder ends with [notifyListeners]; the other changes are made by
/// the files view inside its own `setState`.
class FileTreeController extends ChangeNotifier {
  static final Map<String, Set<String>> _expandedByStorage = {};

  final Map<String, FileSystemDirectory<NoteFile>> _directories = {};
  // Pending reads by folder; removing one discards its result.
  final Map<String, Object> _loading = {};
  final Set<String> _stale = {};
  final Map<String, Object> _errors = {};
  late DocumentFileSystem _documentSystem;
  String? _remote;
  bool _disposed = false;

  /// Whether reading a folder also reads its files, for thumbnails.
  bool Function() readData = () => false;

  /// Called when a folder was read again, with null when it no longer exists.
  void Function(String path, FileSystemDirectory<NoteFile>? directory)? onRead;

  @visibleForTesting
  static void collapseAll() => _expandedByStorage.clear();

  Set<String> get _expanded =>
      _expandedByStorage.putIfAbsent(_remote ?? '', () => {});

  /// The folders read so far.
  Iterable<FileSystemDirectory<NoteFile>> get directories =>
      _directories.values;

  String pathOf(FileSystemEntity<NoteFile> entity) =>
      _documentSystem.normalizePath(entity.path);

  bool isExpanded(FileSystemEntity<NoteFile> entity) =>
      entity is FileSystemDirectory<NoteFile> &&
      _expanded.contains(pathOf(entity));

  /// Whether the folder at [path] was read.
  bool isRead(String path) => _directories.containsKey(path);

  /// Why the folder at [path] could not be read, until the next refresh.
  Object? errorOf(String path) => _errors[path];

  /// Uses [documentSystem] and reads the loaded folders again when shown.
  void reset(DocumentFileSystem documentSystem) {
    _documentSystem = documentSystem;
    _loading.clear();
    _errors.clear();
    final remote = documentSystem.storage?.identifier ?? '';
    if (_remote != remote) {
      _remote = remote;
      _directories.clear();
    }
    // Keep showing the loaded folders until they are read again.
    _stale
      ..clear()
      ..addAll(_directories.keys);
  }

  /// Expands or collapses [directory]; returns whether it is now expanded.
  bool toggle(FileSystemEntity<NoteFile> directory) {
    final path = pathOf(directory);
    if (_expanded.remove(path)) return false;
    _expanded.add(path);
    return true;
  }

  /// Expands the folder at [path].
  void expand(String path) =>
      _expanded.add(_documentSystem.normalizePath(path));

  Future<void> _load(String path) async {
    if (_loading.containsKey(path)) return;
    final load = _loading[path] = Object();
    FileSystemEntity<NoteFile>? asset;
    Object? error;
    try {
      asset = await _documentSystem.getAsset(
        path,
        listLevel: noListLevel,
        readData: readData(),
      );
    } catch (e) {
      error = e;
    }
    if (_disposed || _loading[path] != load) return;
    _loading.remove(path);
    _stale.remove(path);
    if (error != null) {
      // Keep the folder and what was read before, until the next refresh.
      _errors[path] = error;
    } else if (asset is FileSystemDirectory<NoteFile>) {
      _directories[path] = asset;
      onRead?.call(path, asset);
    } else {
      _directories.remove(path);
      _expanded.remove(path);
      onRead?.call(path, null);
    }
    notifyListeners();
  }

  /// The content of [directory], read when it is not loaded yet or stale.
  FileSystemDirectory<NoteFile>? children(
    FileSystemDirectory<NoteFile> directory,
  ) {
    final path = pathOf(directory);
    final loaded = _directories[path];
    if ((loaded == null || _stale.contains(path)) &&
        !_errors.containsKey(path)) {
      _load(path);
    }
    // The listing of the current folder already contains its subfolders.
    return loaded ?? (directory.assets.isEmpty ? null : directory);
  }

  /// The rows of the tree below [assets], sorted with [compare]. While
  /// searching, a folder stays visible if a loaded descendant matches.
  List<FileTreeRow> rows(
    List<FileSystemEntity<NoteFile>> assets, {
    String search = '',
    required Comparator<FileSystemEntity<NoteFile>> compare,
  }) {
    final rows = <FileTreeRow>[];
    search = search.toLowerCase();
    bool isVisible(FileSystemEntity<NoteFile> asset) {
      if (search.isEmpty || asset.fileName.toLowerCase().contains(search)) {
        return true;
      }
      if (asset is! FileSystemDirectory<NoteFile> || !isExpanded(asset)) {
        return false;
      }
      return children(asset)?.assets.any(isVisible) ?? false;
    }

    void addRows(List<FileSystemEntity<NoteFile>> assets, int depth) {
      final visible = assets.where(isVisible).toList()..sort(compare);
      for (final asset in visible) {
        rows.add((entity: asset, path: asset.path, depth: depth));
        if (asset is! FileSystemDirectory<NoteFile> || !isExpanded(asset)) {
          continue;
        }
        final directory = children(asset);
        final count = rows.length;
        if (directory != null) addRows(directory.assets, depth + 1);
        if (rows.length == count && (directory == null || search.isEmpty)) {
          rows.add((entity: null, path: pathOf(asset), depth: depth + 1));
        }
      }
    }

    addRows(assets, 0);
    return rows;
  }

  /// Applies the rename, creation or deletion of [original] to the folder
  /// that contains it.
  void update(AssetLocation original, FileSystemEntity<NoteFile>? replacement) {
    final parent = _documentSystem.normalizePath(original.parent);
    // A pending read of the folder may predate the change.
    if (_loading.remove(parent) != null) _stale.add(parent);
    final directory = _directories[parent];
    if (directory != null) {
      final assets = directory.assets
          .where((asset) => asset.location != original)
          .toList();
      if (replacement != null) assets.add(replacement);
      _directories[parent] = directory.withAssets(assets);
    }
    move(
      _documentSystem.normalizePath(original.path),
      replacement is FileSystemDirectory<NoteFile> ? pathOf(replacement) : null,
    );
  }

  /// A folder moved from [path] to [newPath] keeps its expanded subfolders;
  /// without [newPath] it was deleted.
  void move(String path, String? newPath) {
    bool isInside(String key) => key == path || key.startsWith('$path/');
    final expanded = _expanded.where(isInside).toList();
    _expanded.removeAll(expanded);
    _directories.removeWhere((key, _) => isInside(key));
    _loading.removeWhere((key, _) => isInside(key));
    _errors.removeWhere((key, _) => isInside(key));
    if (newPath == null) return;
    _expanded.addAll(
      expanded.map((key) => '$newPath${key.substring(path.length)}'),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// The rows of the tree layout. Dropping an asset on a file or a placeholder
/// moves it into that folder; folders take drops themselves.
class FileTreeView extends StatelessWidget {
  final FileTreeController controller;
  final List<FileTreeRow> rows;
  final bool collapsed;
  final Widget Function(FileSystemEntity<NoteFile>) buildItem;
  final ValueChanged<FileSystemEntity<NoteFile>> onToggle;
  final Future<void> Function(String source, String directory) onMoveInto;

  /// Width an item keeps however deep it is nested.
  static const double minItemWidth = 240;

  const FileTreeView({
    super.key,
    required this.controller,
    required this.rows,
    required this.buildItem,
    required this.onToggle,
    required this.onMoveInto,
    this.collapsed = false,
  });

  Widget _buildDropTarget(String directory, Widget child) => DragTarget<String>(
    builder: (context, candidateData, rejectedData) =>
        highlightDropTarget(context, candidateData.isNotEmpty, child),
    onWillAcceptWithDetails: (details) =>
        canMoveAssetInto(details.data, directory),
    onAcceptWithDetails: (details) => onMoveInto(details.data, directory),
  );

  Widget _buildRow(BuildContext context, FileTreeRow row, double width) {
    final indent = min(
      row.depth * (collapsed ? 16.0 : 24.0),
      max(0.0, width - 40 - minItemWidth),
    );
    final entity = row.entity;
    if (entity == null) {
      final error = controller.errorOf(row.path);
      final style = TextTheme.of(context).bodySmall
          ?.copyWith(color: ColorScheme.of(context).outline);
      return _buildDropTarget(
        row.path,
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: indent + 40,
            top: 8,
            bottom: 8,
          ),
          child: error != null
              ? Text(
                  '${AppLocalizations.of(context).error}: $error',
                  style: style?.copyWith(color: ColorScheme.of(context).error),
                )
              : controller.isRead(row.path)
              ? Text(AppLocalizations.of(context).noElements, style: style)
              : const LinearProgressIndicator(),
        ),
      );
    }
    final directory = entity is FileSystemDirectory<NoteFile>;
    final expanded = controller.isExpanded(entity);
    final content = Padding(
      padding: EdgeInsetsDirectional.only(start: indent),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: directory
                ? IconButton(
                    onPressed: () => onToggle(entity),
                    tooltip: expanded
                        ? AppLocalizations.of(context).collapse
                        : AppLocalizations.of(context).expand,
                    iconSize: 18,
                    icon: PhosphorIcon(
                      expanded
                          ? PhosphorIconsLight.caretDown
                          : PhosphorIconsLight.caretRight,
                      textDirection: .ltr,
                    ),
                  )
                : null,
          ),
          Expanded(child: buildItem(entity)),
        ],
      ),
    );
    // A folder that refuses a drop (the asset is already in it) must not
    // pass it on to its parent.
    return directory
        ? content
        : _buildDropTarget(entity.location.parent, content);
  }

  @override
  Widget build(BuildContext context) {
    // The items themselves use the location as key.
    Key getRowKey(FileTreeRow row) =>
        ValueKey(('tree', row.entity?.location, row.path));
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        shrinkWrap: true,
        itemCount: rows.length,
        findChildIndexCallback: (key) {
          final index = rows.indexWhere((row) => getRowKey(row) == key);
          return index < 0 ? null : index;
        },
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final row = rows[index];
          return KeyedSubtree(
            key: getRowKey(row),
            child: _buildRow(context, row, constraints.maxWidth),
          );
        },
      ),
    );
  }
}
