import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarView extends StatefulWidget {
  const ToolbarView({super.key});

  @override
  State<ToolbarView> createState() => _ToolbarViewState();
}

class _ToolbarViewState extends State<ToolbarView> {
  String? currentPalette;
  final GlobalKey _animatedKey = GlobalKey();
  double _height = 75;

  void _setOpened(bool opened) {
    if (opened && _height == 0) {
      _height = 75;
    }
    if (!opened && _height != 0) {
      _height = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) => BlocBuilder<CurrentIndexCubit, CurrentIndex>(
          buildWhen: (previous, current) =>
              previous.temporaryToolbar != current.temporaryToolbar ||
              previous.toolbar != current.toolbar,
          builder: (context, currentIndex) {
            Widget? child;
            if (state is! DocumentLoadSuccess) {
              _setOpened(false);
            } else {
              final toolbar =
                  currentIndex.temporaryToolbar ?? currentIndex.toolbar;
              if (toolbar == null) {
                _setOpened(false);
              } else {
                _setOpened(true);
                child = toolbar;
              }
            }
            return AnimatedContainer(
              height: _height,
              key: _animatedKey,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 200),
              child: child,
            );
          }),
    ));
  }
}
