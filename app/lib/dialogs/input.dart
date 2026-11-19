import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_leap/material_leap.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

class InputMappingOptions extends StatefulWidget {
  final InputMapping? startingValue;
  final ValueChanged<InputMapping?> onChanged;
  final bool allowNone;

  const InputMappingOptions({
    super.key,
    required this.startingValue,
    required this.onChanged,
    this.allowNone = false,
  });

  @override
  State<InputMappingOptions> createState() => _InputMappingOptionsState();
}

class _InputMappingOptionsState extends State<InputMappingOptions> {
  InputMappingCategory? _category;
  PackAssetLocation? _preset;
  final TextEditingController _toolbarToolPositionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _category = widget.startingValue?.getCategory();
    _preset = widget.startingValue?.preset;
    _toolbarToolPositionController.text =
        widget.startingValue?.getToolDisplayPosition()?.toString() ?? '1';
  }

  @override
  void dispose() {
    super.dispose();
    _toolbarToolPositionController.dispose();
  }

  void _onCategoryChanged(InputMappingCategory? value) async {
    if (value == .preset && _preset == null) {
      await _selectPreset();
      return;
    }
    setState(() {
      _category = value;
    });
    _onChanged();
  }

  void _toolbarToolPositionChanged(String value) {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      setState(() {
        _toolbarToolPositionController.text = intValue.clamp(1, 99).toString();
      });
    } else if (value != '') {
      setState(() {
        _toolbarToolPositionController.text = '1';
      });
    }
    _onChanged();
  }

  void _onChanged() {
    final category = _category;
    if (category == null) {
      widget.onChanged(null);
      return;
    }
    if (category == .preset && _preset == null) return;
    widget.onChanged(
      InputMapping.fromUIData(
        category,
        int.tryParse(_toolbarToolPositionController.text),
        _preset,
      ),
    );
  }

  Future<void> _selectPreset() async {
    final fileSystem = context.read<ButterflyFileSystem>();
    final result = await showDialog<PackItem>(
      context: context,
      builder: (context) => RepositoryProvider.value(
        value: fileSystem,
        child: SelectPackAssetDialog(
          selected: _preset,
          getItems: (pack) => pack.getNamedToolPresets(),
        ),
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      _preset = result.location;
      _category = .preset;
    });
    _onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final preset = _preset;
    return RadioGroup<InputMappingCategory?>(
      groupValue: _category,
      onChanged: _onCategoryChanged,
      child: Column(
        children: [
          if (widget.allowNone)
            RadioListTile<InputMappingCategory?>(
              title: Text(AppLocalizations.of(context).none),
              value: null,
            ),
          RadioListTile<InputMappingCategory?>(
            title: Text(AppLocalizations.of(context).activeTool),
            subtitle: Text(AppLocalizations.of(context).activeToolDescription),
            value: InputMappingCategory.activeTool,
          ),
          RadioListTile<InputMappingCategory?>(
            title: Text(AppLocalizations.of(context).handTool),
            subtitle: Text(AppLocalizations.of(context).handToolDescription),
            value: InputMappingCategory.handTool,
          ),
          RadioListTile<InputMappingCategory?>(
            value: InputMappingCategory.toolOnToolbar,
            title: Text(AppLocalizations.of(context).toolOnToolbar),
            subtitle: Text(
              AppLocalizations.of(context).toolOnToolbarDescription,
            ),
            secondary: SizedBox(
              width: 50,
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                decoration: InputDecoration(filled: true),
                enabled: _category == .toolOnToolbar,
                controller: _toolbarToolPositionController,
                onTap: () {
                  _toolbarToolPositionController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        _toolbarToolPositionController.value.text.length,
                  );
                },
                onEditingComplete: () {
                  if (_toolbarToolPositionController.text.isEmpty) {
                    _toolbarToolPositionController.text = '1';
                  }
                  FocusScope.of(context).unfocus();
                },
                onChanged: _toolbarToolPositionChanged,
                textAlign: .center,
              ),
            ),
          ),
          RadioListTile<InputMappingCategory?>(
            value: InputMappingCategory.preset,
            title: Text(AppLocalizations.of(context).presets),
            subtitle: preset == null
                ? Text(AppLocalizations.of(context).selectAsset)
                : InputMappingDescription(mapping: InputMapping.preset(preset)),
            secondary: IconButton(
              tooltip: AppLocalizations.of(context).selectAsset,
              icon: const Icon(Icons.folder_open),
              onPressed: _selectPreset,
            ),
          ),
          SizedBox(
            // This adds space at the bottom of the fly-out to account for the keyboard appearing
            height: MediaQuery.viewInsetsOf(context).bottom,
          ),
        ],
      ),
    );
  }
}

class InputMappingDescription extends StatelessWidget {
  final InputMapping? mapping;

  const InputMappingDescription({super.key, required this.mapping});

  Widget _buildPreset(
    BuildContext context,
    PackAssetLocation location,
    Tool? tool,
  ) {
    final name = tool?.getDisplay(context) ?? location.key;
    final packName = context.read<ButterflyFileSystem>().getToolPresetPackName(
      location,
    );
    return Text('$name · $packName');
  }

  @override
  Widget build(BuildContext context) {
    final preset = mapping?.preset;
    if (preset == null) {
      return Text(
        mapping?.getDescription(context) ?? AppLocalizations.of(context).none,
      );
    }
    final location = normalizeToolPresetLocation(preset);
    final result = context.read<ButterflyFileSystem>().getToolPreset(location);
    if (result is Future<Tool?>) {
      return FutureBuilder<Tool?>(
        key: ValueKey(location),
        future: result,
        builder: (context, snapshot) =>
            _buildPreset(context, location, snapshot.data),
      );
    }
    return _buildPreset(context, location, result);
  }
}

Future<void> openInputMappingModal(
  BuildContext context,
  String mappingName,
  InputMapping? startingValue,
  ValueChanged<InputMapping?> onChanged, {
  bool allowNone = false,
}) => showLeapBottomSheet(
  context: context,
  titleBuilder: (ctx) => Text(mappingName),
  childrenBuilder: (ctx) {
    return [
      InputMappingOptions(
        startingValue: startingValue,
        onChanged: onChanged,
        allowNone: allowNone,
      ),
    ];
  },
);
