import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';
import '../dialogs/color_pick.dart';

class ColorField extends StatelessWidget {
  final bool enabled;
  final Color color;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final ValueChanged<Color>? onChanged;

  const ColorField(
      {Key? key,
      this.color = Colors.white,
      this.enabled = true,
      this.leading,
      this.title,
      this.subtitle,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          var nextColor = await showDialog(
              context: context,
              builder: (ctx) => BlocProvider.value(
                    value: context.read<DocumentBloc>(),
                    child: ColorPickerDialog(defaultColor: color),
                  )) as int?;
          if (nextColor != null) {
            onChanged?.call(Color(nextColor));
          }
        },
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: color,
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(32))),
        ));
  }
}
