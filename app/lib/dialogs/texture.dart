import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TextureView extends StatefulWidget {
  final SurfaceTexture value;
  final ValueChanged<SurfaceTexture> onChanged;

  const TextureView({super.key, required this.value, required this.onChanged});

  @override
  State<TextureView> createState() => _TextureViewState();
}

class _TextureViewState extends State<TextureView> {
  int? currentExpansionOpened = -1;

  @override
  void didUpdateWidget(covariant TextureView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar.secondary(
            tabs: [
              HorizontalTab(
                label: Text(AppLocalizations.of(context).background),
                icon: const PhosphorIcon(PhosphorIconsLight.rectangle),
              ),
              HorizontalTab(
                label: Text(AppLocalizations.of(context).horizontal),
                icon: const PhosphorIcon(PhosphorIconsLight.arrowsHorizontal),
              ),
              HorizontalTab(
                label: Text(AppLocalizations.of(context).vertical),
                icon: const PhosphorIcon(PhosphorIconsLight.arrowsVertical),
              ),
            ],
          ),
          Expanded(
            child: Material(
              type: MaterialType.transparency,
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      ColorField(
                        value: widget.value.boxColor.withValues(a: 255),
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(
                            boxColor: value.withValues(
                              a: widget.value.boxColor.a,
                            ),
                          ),
                        ),
                        title: Text(LeapLocalizations.of(context).color),
                      ),
                      ExactSlider(
                        value: widget.value.boxColor.a.toDouble(),
                        header: Text(AppLocalizations.of(context).alpha),
                        fractionDigits: 0,
                        max: 255,
                        min: 0,
                        defaultValue: 255,
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(
                            boxColor: widget.value.boxColor.withValues(
                              a: value.toInt(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      ColorField(
                        value: widget.value.boxXColor.withValues(a: 255),
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(
                            boxXColor: value.withValues(
                              a: widget.value.boxXColor.a,
                            ),
                          ),
                        ),
                        title: Text(LeapLocalizations.of(context).color),
                      ),
                      ExactSlider(
                        value: widget.value.boxXColor.a.toDouble(),
                        header: Text(AppLocalizations.of(context).alpha),
                        fractionDigits: 0,
                        max: 255,
                        min: 0,
                        defaultValue: 255,
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(
                            boxXColor: widget.value.boxXColor.withValues(
                              a: value.toInt(),
                            ),
                          ),
                        ),
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxWidth: value),
                        ),
                        header: Text(AppLocalizations.of(context).width),
                        value: widget.value.boxWidth,
                        defaultValue: 0,
                        min: 0,
                        max: 500,
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxXCount: value.round()),
                        ),
                        header: Text(AppLocalizations.of(context).count),
                        value: widget.value.boxXCount.toDouble(),
                        fractionDigits: 0,
                        defaultValue: 0,
                        min: 0,
                        max: 20,
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxXSpace: value),
                        ),
                        header: Text(AppLocalizations.of(context).space),
                        value: widget.value.boxXSpace,
                        defaultValue: 0,
                        min: 0,
                        max: 500,
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxXStroke: value),
                        ),
                        header: Text(AppLocalizations.of(context).strokeWidth),
                        value: widget.value.boxXStroke,
                        defaultValue: 0.5,
                        min: 0.1,
                        max: 50,
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      ColorField(
                        value: widget.value.boxYColor.withValues(a: 255),
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(
                            boxYColor: value.withValues(
                              a: widget.value.boxYColor.a,
                            ),
                          ),
                        ),
                        title: Text(LeapLocalizations.of(context).color),
                      ),
                      ExactSlider(
                        value: widget.value.boxYColor.a.toDouble(),
                        header: Text(AppLocalizations.of(context).alpha),
                        fractionDigits: 0,
                        max: 255,
                        min: 0,
                        defaultValue: 255,
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(
                            boxYColor: widget.value.boxYColor.withValues(
                              a: value.toInt(),
                            ),
                          ),
                        ),
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxHeight: value),
                        ),
                        header: Text(AppLocalizations.of(context).width),
                        value: widget.value.boxHeight,
                        defaultValue: 0,
                        min: 0,
                        max: 500,
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxYCount: value.round()),
                        ),
                        header: Text(AppLocalizations.of(context).count),
                        value: widget.value.boxYCount.toDouble(),
                        defaultValue: 0,
                        fractionDigits: 0,
                        min: 0,
                        max: 20,
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxYSpace: value),
                        ),
                        header: Text(AppLocalizations.of(context).space),
                        value: widget.value.boxYSpace,
                        defaultValue: 0,
                        min: 0,
                        max: 500,
                      ),
                      ExactSlider(
                        onChanged: (value) => widget.onChanged(
                          widget.value.copyWith(boxYStroke: value),
                        ),
                        header: Text(AppLocalizations.of(context).strokeWidth),
                        value: widget.value.boxYStroke,
                        defaultValue: 0.5,
                        min: 0.1,
                        max: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
