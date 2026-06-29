import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kToolbarSmall = Size.fromHeight(48.0);
const kToolbarLarge = Size.fromHeight(75.0);

class ToolbarView extends StatefulWidget {
  const ToolbarView({super.key});

  @override
  State<ToolbarView> createState() => _ToolbarViewState();
}

class _ToolbarViewState extends State<ToolbarView> {
  String? currentPalette;
  final GlobalKey _animatedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.toolbarPosition != current.toolbarPosition,
      builder: (context, state) {
        return Align(
          child: Card(
            child: BlocBuilder<ToolCubit, ToolRuntimeState>(
              buildWhen: (previous, current) =>
                  previous.temporaryToolbar != current.temporaryToolbar ||
                  previous.toolbar != current.toolbar,
              builder: (context, toolState) {
                Widget? child;
                var height = 0.0;
                final toolbar = toolState.temporaryToolbar ?? toolState.toolbar;
                if (toolbar != null) {
                  height = toolbar.preferredSize.height;
                  child = toolbar;
                }
                return AnimatedContainer(
                  height: height,
                  key: _animatedKey,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.fastOutSlowIn,
                    child: child,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
