import 'package:flutter/material.dart';

import '../../../models/text.dart';

class TextsStyleView extends StatelessWidget {
  final TextStyleSheet styleSheet;
  final ValueChanged<TextStyleSheet> onChanged;

  const TextsStyleView({
    super.key,
    required this.styleSheet,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
