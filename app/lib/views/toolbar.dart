import 'package:butterfly/cubits/current_index.dart';
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
    return Card(
      child: BlocBuilder<CurrentIndexCubit, CurrentIndex>(
          buildWhen: (previous, current) =>
              previous.temporaryToolbar != current.temporaryToolbar ||
              previous.toolbar != current.toolbar,
          builder: (context, currentIndex) {
            Widget? child;
            var height = 0.0;
            final toolbar =
                currentIndex.temporaryToolbar ?? currentIndex.toolbar;
            if (toolbar != null) {
              height = toolbar.preferredSize.height;
              child = toolbar;
            }
            return AnimatedContainer(
              height: height,
              key: _animatedKey,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 200),
              child: child,
            );
          }),
    );
  }
}
