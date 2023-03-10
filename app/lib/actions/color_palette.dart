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
  Future<void> invoke(ColorPaletteIntent intent) {
    return showDialog<void>(
      context: intent.context,
      builder: (ctx) => ColorPickerDialog(
        viewMode: true,
        bloc: intent.context.read<DocumentBloc>(),
      ),
    );
  }
}
