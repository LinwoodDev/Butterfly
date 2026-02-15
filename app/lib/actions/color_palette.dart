import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/packs/color_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPaletteIntent extends Intent {
  const ColorPaletteIntent();
}

class ColorPaletteAction extends Action<ColorPaletteIntent> {
  final BuildContext context;

  ColorPaletteAction(this.context);

  @override
  Future<void> invoke(ColorPaletteIntent intent) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => ColorPalettePickerDialog(
        viewMode: true,
        bloc: context.read<DocumentBloc>(),
      ),
    );
  }
}
