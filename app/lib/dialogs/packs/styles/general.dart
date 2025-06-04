import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';

class GeneralStyleView extends StatelessWidget {
  final TextStyleSheet value;
  final ValueChanged<TextStyleSheet> onChanged;

  const GeneralStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: []);
  }
}
