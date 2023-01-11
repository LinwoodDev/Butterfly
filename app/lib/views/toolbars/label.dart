import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LabelToolbarView extends StatefulWidget {
  const LabelToolbarView({super.key});

  @override
  State<LabelToolbarView> createState() => _LabelToolbarViewState();
}

class _LabelToolbarViewState extends State<LabelToolbarView> {
  bool _paragraphMode = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.articleLight),
              isSelected: _paragraphMode,
              onPressed: () => setState(() => _paragraphMode = !_paragraphMode),
            ),
            const Text('A'),
            const Text('B'),
          ],
        ),
      )),
    );
  }
}
