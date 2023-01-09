import 'package:flutter/material.dart';

import '../../models/pack.dart';

class ComponentsPackView extends StatelessWidget {
  final ButterflyPack pack;
  final ValueChanged<ButterflyPack> onChanged;

  const ComponentsPackView({
    super.key,
    required this.pack,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: pack.components
              .asMap()
              .entries
              .map(
                (e) => Dismissible(
                  key: ValueKey(e.key),
                  onDismissed: (direction) {
                    onChanged(pack.copyWith(
                      components: pack.components..remove(e.value),
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
