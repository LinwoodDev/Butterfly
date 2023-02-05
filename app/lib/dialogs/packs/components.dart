import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

class ComponentsPackView extends StatelessWidget {
  final ButterflyPack value;
  final ValueChanged<ButterflyPack> onChanged;

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
          children: value.components
              .asMap()
              .entries
              .map(
                (e) => Dismissible(
                  key: ValueKey(e.key),
                  onDismissed: (direction) {
                    onChanged(value.copyWith(
                      components: value.components..remove(e.value),
                    ));
                  },
                  child: ListTile(
                    title: Text(e.value.name),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
