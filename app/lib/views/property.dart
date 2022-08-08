import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/exact_slider.dart';
import '../widgets/header.dart';

class PropertyView extends StatefulWidget {
  const PropertyView({super.key});

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  bool pinned = false;
  bool opened = true;
  double size = 500;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width < size;
        return Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: isMobile ? 0 : 8),
          constraints: BoxConstraints(maxWidth: size),
          child: Material(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    bottomLeft: const Radius.circular(20),
                    bottomRight: Radius.circular(isMobile ? 20 : 0),
                    topRight: Radius.circular(isMobile ? 20 : 0))),
            child: Row(
              children: [
                if (!isMobile)
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: GestureDetector(
                      child: const Icon(PhosphorIcons.dotsSixVerticalLight),
                      onPanUpdate: (details) {
                        final delta = details.delta.dx;
                        setState(() {
                          size -= delta;
                          size = size.clamp(250, 500);
                        });
                      },
                    ),
                  ),
                Flexible(
                  child: Column(
                    children: [
                      Header(
                        title: Text(AppLocalizations.of(context)!.property),
                        actions: [
                          if (!isMobile)
                            IconButton(
                              icon: pinned
                                  ? const Icon(PhosphorIcons.mapPinFill)
                                  : const Icon(PhosphorIcons.mapPinLight),
                              onPressed: () => setState(() => pinned = !pinned),
                            ),
                          IconButton(
                            icon: const Icon(PhosphorIcons.xLight),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(shrinkWrap: true, children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText:
                                      AppLocalizations.of(context)!.name),
                            ),
                            const SizedBox(height: 8),
                            ExactSlider(
                              header: Text(
                                  AppLocalizations.of(context)!.strokeWidth),
                              min: 0,
                              max: 70,
                              defaultValue: 5,
                            ),
                            ExactSlider(
                              header: Text(AppLocalizations.of(context)!
                                  .strokeMultiplier),
                              min: 0,
                              max: 70,
                              defaultValue: 5,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
