import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPaletteIntent extends Intent {
  final BuildContext context;

  const ColorPaletteIntent(this.context);
}

class ColorPaletteAction extends Action<ColorPaletteIntent> {
  ColorPaletteAction();

  @override
  Object? invoke(ColorPaletteIntent intent) {
    showDialog(
      context: intent.context,
      builder: (ctx) => BlocProvider.value(
          value: intent.context.read<DocumentBloc>(),
          child: const ColorPickerDialog(viewMode: true)),
    );
  }
}
