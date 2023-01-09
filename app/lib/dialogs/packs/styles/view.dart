import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../models/pack.dart';

class StylesPackView extends StatelessWidget {
  final ButterflyPack pack;
  final ValueChanged<ButterflyPack> onChanged;

  const StylesPackView({
    super.key,
    required this.pack,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: pack.styles
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(PhosphorIcons.plusLight),
              label: Text(AppLocalizations.of(context).create),
            ),
          ),
        ],
      ),
    );
  }
}
