import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../bloc/document_bloc.dart';
import '../dialogs/packs/color_pick.dart';

class ColorField extends StatelessWidget {
  final bool enabled, custom;
  final SRGBColor value;
  final SRGBColor? defaultColor;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final ValueChanged<SRGBColor>? onChanged;
  final VoidCallback? onOpen;

  const ColorField({
    super.key,
    this.value = SRGBColor.white,
    this.defaultColor,
    this.custom = false,
    this.enabled = true,
    this.leading,
    this.title,
    this.subtitle,
    this.onOpen,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        onOpen?.call();
        SRGBColor? nextColor;
        if (custom) {
          final response = await showDialog<ColorPickerResponse>(
            context: context,
            builder: (ctx) => ColorPicker(value: value),
          );
          nextColor = response?.toSRGB();
        } else {
          nextColor = await showDialog<SRGBColor>(
            context: context,
            builder: (ctx) => ColorPalettePickerDialog(
              value: value,
              bloc: context.read<DocumentBloc>(),
            ),
          );
        }
        if (nextColor != null) {
          onChanged?.call(nextColor);
        }
      },
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: value.toColor(),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
          ),
          if (defaultColor != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const PhosphorIcon(
                PhosphorIconsLight.clockCounterClockwise,
              ),
              tooltip: LeapLocalizations.of(context).reset,
              onPressed: () async {
                onChanged?.call(defaultColor!);
              },
            ),
          ],
        ],
      ),
    );
  }
}
