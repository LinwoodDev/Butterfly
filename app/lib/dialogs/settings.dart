import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputMappingOptions extends StatefulWidget {
  final InputMapping startingValue;
  final ValueChanged<InputMapping> onChanged;

  const InputMappingOptions({
    super.key,
    required this.startingValue,
    required this.onChanged,
  });

  @override
  State<InputMappingOptions> createState() => _InputMappingOptionsState();
}

class _InputMappingOptionsState extends State<InputMappingOptions> {
  InputMappingCategory? _category;
  final TextEditingController _toolbarToolPositionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _category = widget.startingValue.getCategory();
    _toolbarToolPositionController.text =
        widget.startingValue.getToolDisplayPosition()?.toString() ?? '1';
  }

  void _onCategoryChanged(InputMappingCategory? value) {
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
    widget.onChanged(
      InputMapping.fromCategory(
        _category!,
        int.tryParse(_toolbarToolPositionController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() => _onCategoryChanged(InputMappingCategory.activeTool));
          },
          child: ListTile(
            title: Text(AppLocalizations.of(context).activeTool),
            subtitle:
                Text('Use the currently-selected tool on the toolbar'), // TODO
            leading: Radio<InputMappingCategory>(
              value: InputMappingCategory.activeTool,
              groupValue: _category,
              onChanged: _onCategoryChanged,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() => _onCategoryChanged(InputMappingCategory.handTool));
          },
          child: ListTile(
            title: Text(AppLocalizations.of(context).handTool),
            subtitle: Text('Drag to move around the canvas'), // TODO
            leading: Radio<InputMappingCategory>(
              value: InputMappingCategory.handTool,
              groupValue: _category,
              onChanged: _onCategoryChanged,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(
                () => _onCategoryChanged(InputMappingCategory.toolOnToolbar));
          },
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(AppLocalizations.of(context).toolOnToolbar),
                  subtitle: Text(
                      'Use the tool at the specified position on the toolbar\n(1 is the left-most tool)'), // TODO
                  leading: Radio<InputMappingCategory>(
                    value: InputMappingCategory.toolOnToolbar,
                    groupValue: _category,
                    onChanged: _onCategoryChanged,
                  ),
                ),
              ),
              SizedBox(
                width: 30, // TODO
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  enabled: _category == InputMappingCategory.toolOnToolbar,
                  controller: _toolbarToolPositionController,
                  onTap: () {
                    _toolbarToolPositionController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset:
                            _toolbarToolPositionController.value.text.length);
                  },
                  onEditingComplete: () {
                    if (_toolbarToolPositionController.text == '') {
                      _toolbarToolPositionController.text = '1';
                    }
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: _toolbarToolPositionChanged,
                  textAlign: TextAlign.center,
                  // decoration: InputDecoration(
                  //   // labelText: 'Tool number', // TODO: Add translation
                  // ),
                ),
              ),
              const SizedBox(width: 35),
            ],
          ),
        ),
        SizedBox(
          // This adds space at the bottom of the fly-out to account for the keyboard appearing
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ],
    );
  }
}

IconButton resetButtonDecoration(BuildContext context, VoidCallback onPressed) {
  return IconButton(
    onPressed: onPressed,
    tooltip: LeapLocalizations.of(context).reset,
    icon: const PhosphorIcon(PhosphorIconsLight.clockClockwise),
  );
}

Future<void> openInputMappingModal(
  BuildContext context,
  String mappingName,
  InputMapping startingValue,
  ValueChanged<InputMapping> onChanged,
) =>
    showLeapBottomSheet(
      context: context,
      titleBuilder: (ctx) => Text(mappingName),
      childrenBuilder: (ctx) {
        // final settingsCubit = context.read<SettingsCubit>();
        // void changeSyncMode(SyncMode syncMode) {
        //   settingsCubit.changeSyncMode(syncMode);
        //   Navigator.of(context).pop();
        // }

        return [
          InputMappingOptions(
            startingValue: startingValue,
            onChanged: onChanged,
          )
        ];
      },
    );
