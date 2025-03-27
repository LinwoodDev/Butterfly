import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputMappingOptions extends StatefulWidget {
  final InputMapping startingValue;
  const InputMappingOptions({super.key, required this.startingValue});

  @override
  State<InputMappingOptions> createState() => _InputMappingOptionsState();
}

class _InputMappingOptionsState extends State<InputMappingOptions> {
  InputMappingCategory? _category = InputMappingCategory.activeTool;
  int _toolbarToolDisplayIndex = 0;
  TextEditingController _toolbarToolIndexController = TextEditingController(
    text: '1',
  );

  void _onCategoryChanged(InputMappingCategory? value) {
    setState(() {
      _category = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context).activeTool),
          subtitle:
              Text('Use the currently-selected tool on the toolbar'), // TODO
          leading: Radio<InputMappingCategory>(
            value: InputMappingCategory.activeTool,
            groupValue: _category,
            onChanged: _onCategoryChanged,
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).handTool),
          subtitle: Text('Drag to move around the canvas'), // TODO
          leading: Radio<InputMappingCategory>(
            value: InputMappingCategory.handTool,
            groupValue: _category,
            onChanged: _onCategoryChanged,
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).toolOnToolbar),
          subtitle: Text(
              'Use the tool at the specified position on the toolbar (1 is the left-most tool)'), // TODO
          leading: Radio<InputMappingCategory>(
            value: InputMappingCategory.toolOnToolbar,
            groupValue: _category,
            onChanged: _onCategoryChanged,
          ),
          // trailing: SizedBox(
          //   width: 100, // TODO
          //   child: TextFormField(
          //     controller: _toolbarToolIndexController,
          //     onChanged: (String value) {
          //       final int? intValue = int.tryParse(value);
          //       if (intValue != null) {
          //         setState(() {
          //           _toolbarToolDisplayIndex = intValue;
          //         });
          //       }
          //     },
          //     decoration: InputDecoration(
          //       labelText: 'Tool number', // TODO: Add translation
          //     ),
          //   ),
          // ),
        ),
        Row(
          children: [
            const SizedBox(width: 80),
            Text(
              'Tool number', // TODO: Add translation
            ),
            const SizedBox(width: 20),
            // Expanded(
            //   child: Container(),
            // ),
            SizedBox(
              width: 40, // TODO
              child: TextFormField(
                enabled: false,
                controller: _toolbarToolIndexController,
                onChanged: (String value) {
                  final int? intValue = int.tryParse(value);
                  if (intValue != null) {
                    setState(() {
                      _toolbarToolDisplayIndex = intValue;
                    });
                  }
                },
                textAlign: TextAlign.center,
                // decoration: InputDecoration(
                //   // labelText: 'Tool number', // TODO: Add translation
                // ),
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: ListTile(
        //         title: Text(AppLocalizations.of(context).toolOnToolbar),
        //         leading: Radio<InputMappingCategory>(
        //           value: InputMappingCategory.toolOnToolbar,
        //           groupValue: _category,
        //           onChanged: _onCategoryChanged,
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: TextFormField(
        //         controller: _toolbarToolIndexController,
        //         onChanged: (String value) {
        //           final int? intValue = int.tryParse(value);
        //           if (intValue != null) {
        //             setState(() {
        //               _toolbarToolDisplayIndex = intValue;
        //             });
        //           }
        //         },
        //         decoration: InputDecoration(
        //           labelText: 'Tool number', // TODO: Add translation
        //           icon: Container(),
        //         ),
        //       ),
        //       // child: Text('hello!'),
        //     ),
        //   ],
        // ),
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
  VoidCallback setter,
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

        return [InputMappingOptions(startingValue: startingValue)];
      },
    );
