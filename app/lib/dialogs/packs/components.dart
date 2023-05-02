import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

class ComponentsPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const ComponentsPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: value
              .getComponents()
              .map(
                (e) => Dismissible(
                  key: ValueKey(e),
                  onDismissed: (direction) {
                    value.removeComponent(e);
                    onChanged(value);
                  },
                  child: ListTile(
                    title: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
