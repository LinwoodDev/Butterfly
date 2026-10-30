import 'package:material_ui/material_ui.dart';

class AnchorPicker extends StatelessWidget {
  final Offset? value;
  final ValueChanged<Offset?> onChanged;

  const AnchorPicker({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;
    const steps = [0.0, 0.5, 1.0];
    return SizedBox(
      width: 66,
      height: 66,
      child: Column(
        children: [
          for (final y in steps)
            Expanded(
              child: Row(
                children: [
                  for (final x in steps)
                    Expanded(
                      child: InkResponse(
                        // tapping the selected point again clears the anchor
                        onTap: () => onChanged(
                          value == Offset(x, y) ? null : Offset(x, y),
                        ),
                        child: Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: value == Offset(x, y)
                                  ? Colors.orange
                                  : Colors.transparent,
                              border: Border.all(
                                color: value == Offset(x, y)
                                    ? Colors.orange
                                    : outline,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
