import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

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

  @override
  void dispose() {
    super.dispose();
    _toolbarToolPositionController.dispose();
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
      InputMapping.fromUIData(
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
            subtitle: Text(AppLocalizations.of(context).activeToolDescription),
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
            subtitle: Text(AppLocalizations.of(context).handToolDescription),
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
              () => _onCategoryChanged(InputMappingCategory.toolOnToolbar),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(AppLocalizations.of(context).toolOnToolbar),
                  subtitle: Text(
                    AppLocalizations.of(context).toolOnToolbarDescription,
                  ),
                  leading: Radio<InputMappingCategory>(
                    value: InputMappingCategory.toolOnToolbar,
                    groupValue: _category,
                    onChanged: _onCategoryChanged,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  decoration: InputDecoration(filled: true),
                  enabled: _category == InputMappingCategory.toolOnToolbar,
                  controller: _toolbarToolPositionController,
                  onTap: () {
                    _toolbarToolPositionController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          _toolbarToolPositionController.value.text.length,
                    );
                  },
                  onEditingComplete: () {
                    if (_toolbarToolPositionController.text == '') {
                      _toolbarToolPositionController.text = '1';
                    }
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: _toolbarToolPositionChanged,
                  textAlign: TextAlign.center,
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

Future<void> openInputMappingModal(
  BuildContext context,
  String mappingName,
  InputMapping startingValue,
  ValueChanged<InputMapping> onChanged,
) => showLeapBottomSheet(
  context: context,
  titleBuilder: (ctx) => Text(mappingName),
  childrenBuilder: (ctx) {
    return [
      InputMappingOptions(startingValue: startingValue, onChanged: onChanged),
    ];
  },
);
