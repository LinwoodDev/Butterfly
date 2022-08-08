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
  double size = 500;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = MediaQuery.of(context).size.width < size;
      return Stack(children: [
        GestureDetector(
          behavior:
              pinned ? HitTestBehavior.translucent : HitTestBehavior.opaque,
          onTap: () => _closeView,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.all(8),
            constraints: BoxConstraints(maxWidth: size, maxHeight: 500),
            child: Material(
              elevation: 6,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(children: [
                if (!isMobile)
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: GestureDetector(
                      child: const Icon(PhosphorIcons.dotsSixVerticalLight),
                      onPanUpdate: (details) {
                        final delta = details.delta.dx;
                        setState(() {
                          size -= delta;
                          size = size.clamp(300, 500);
                        });
                      },
                    ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Header(
                        title: Text(AppLocalizations.of(context)!.property),
                        actions: [
                          IconButton(
                              icon: const Icon(PhosphorIcons.trashLight),
                              onPressed: () {}),
                          const SizedBox(height: 16, child: VerticalDivider()),
                          if (!isMobile)
                            IconButton(
                              tooltip: pinned
                                  ? AppLocalizations.of(context)!.unpin
                                  : AppLocalizations.of(context)!.pin,
                              icon: pinned
                                  ? const Icon(PhosphorIcons.mapPinFill)
                                  : const Icon(PhosphorIcons.mapPinLight),
                              onPressed: () => setState(() => pinned = !pinned),
                            ),
                          IconButton(
                            tooltip: AppLocalizations.of(context)!.close,
                            icon: const Icon(PhosphorIcons.xLight),
                            onPressed: _closeView,
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
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
                            ExactSlider(
                              header: Text(AppLocalizations.of(context)!
                                  .strokeMultiplier),
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
              ]),
            ),
          ),
        ),
      ]);
    });
  }

  void _closeView() {}
}
