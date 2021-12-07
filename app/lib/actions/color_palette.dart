import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/color_pick.dart';
import 'package:flutter/material.dart';

class ColorPaletteIntent extends Intent {
  final BuildContext context;

  const ColorPaletteIntent(this.context);
}

class ColorPaletteAction extends Action<ColorPaletteIntent> {
  final DocumentBloc bloc;

  ColorPaletteAction(this.bloc);

  @override
  Object? invoke(ColorPaletteIntent intent) {
    showDialog(
      context: intent.context,
      builder: (context) => ColorPickerDialog(
        bloc: bloc,
        viewMode: true,
      ),
    );
  }
}
