import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/services.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

const kCustomFontPrefix = 'Custom-';
const kDefaultFontFamily = 'Roboto';
const kBundledFontFamilies = {
  'Comfortaa',
  'Noto Sans Arabic',
  kDefaultFontFamily,
};

String customFontFamily(String name) => '$kCustomFontPrefix$name';

class AvailableFontFamily {
  final String name;
  final bool bundled;
  final bool system;

  const AvailableFontFamily({
    required this.name,
    required this.bundled,
    required this.system,
  });
}

class FontService {
  final ButterflyFileSystem _fileSystem;
  Future<List<String>>? _systemFonts;
  final Map<String, Future<void>> _loadedFonts = {};
  final Set<String> _customFonts = {};

  FontService(this._fileSystem);

  Future<List<String>> getSystemFonts() => _systemFonts ??= _fetchSystemFonts();

  Future<List<AvailableFontFamily>> getFonts() async {
    await loadFonts();
    final systemFonts = (await getSystemFonts()).toSet();
    final bundledFonts = {...kBundledFontFamilies, ..._customFonts};
    final names = {...systemFonts, ...bundledFonts}.toList()..sort();
    return names
        .map(
          (name) => AvailableFontFamily(
            name: name,
            bundled: bundledFonts.contains(name),
            system: systemFonts.contains(name),
          ),
        )
        .toList();
  }

  Future<void> loadFonts([NoteData? document]) async {
    try {
      final packs = await _fileSystem.getCoreAndUserPacks();
      for (final (_, pack) in packs) {
        await loadFontsFromPack(pack);
      }
      if (document != null) {
        for (final name in document.getBundledPacks()) {
          final pack = document.getBundledPack(name);
          if (pack != null) await loadFontsFromPack(pack);
        }
      }
    } catch (_) {
      // A remote or unavailable pack store must not hide bundled/system fonts.
    }
  }

  Future<void> loadFontsFromPack(NoteData pack) async {
    for (final name in pack.getFonts()) {
      final data = pack.getFont(name);
      if (data != null) await loadFont(name, ByteData.sublistView(data));
    }
  }

  Future<List<String>> _fetchSystemFonts() async {
    try {
      final fonts = await SysAPI.getFonts() ?? const <String>[];
      return fonts.toSet().toList()..sort();
    } catch (_) {
      return const [];
    }
  }

  Future<String?> loadFont(String name, ByteData data) async {
    final dot = name.lastIndexOf('.');
    final baseName = dot > 0 ? name.substring(0, dot) : name;
    final family = baseName.startsWith(kCustomFontPrefix)
        ? baseName
        : customFontFamily(baseName);
    final loading = _loadedFonts.putIfAbsent(family, () async {
      final loader = FontLoader(family)..addFont(Future.value(data));
      await loader.load();
    });
    try {
      await loading;
      _customFonts.add(family);
      return family;
    } catch (_) {
      _loadedFonts.remove(family);
      return null;
    }
  }
}
