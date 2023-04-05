import 'package:butterfly/dialogs/packs/styles/text.dart';
import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ParagraphStyleView extends StatelessWidget {
  final DefinedParagraphProperty value;
  final ValueChanged<DefinedParagraphProperty> onChanged;
  const ParagraphStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ToggleButtons(
            isSelected: [
              value.alignment == HorizontalAlignment.left,
              value.alignment == HorizontalAlignment.center,
              value.alignment == HorizontalAlignment.right,
              value.alignment == HorizontalAlignment.justify,
            ],
            onPressed: (index) {
              var alignments = [
                HorizontalAlignment.left,
                HorizontalAlignment.center,
                HorizontalAlignment.right,
                HorizontalAlignment.justify,
              ];
              onChanged(
                value.copyWith(alignment: alignments[index]),
              );
            },
            children: [
              PhosphorIcon(PhosphorIcons.light.textAlignLeft),
              PhosphorIcon(PhosphorIcons.light.textAlignCenter),
              PhosphorIcon(PhosphorIcons.light.textAlignRight),
              PhosphorIcon(PhosphorIcons.light.textAlignJustify),
            ]),
        const SizedBox(height: 16),
        TextStyleView(
          value: value.span,
          onChanged: (span) => onChanged(
            value.copyWith(span: span),
          ),
        ),
      ],
    );
  }
}
