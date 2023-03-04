import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';

class PresentationToolbarView extends StatefulWidget {
  const PresentationToolbarView({
    super.key,
  });

  @override
  State<PresentationToolbarView> createState() =>
      _PresentationToolbarViewState();
}

class _PresentationToolbarViewState extends State<PresentationToolbarView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _frameController = TextEditingController(),
      _durationController = TextEditingController();
  String? _selected;
  @override
  void initState() {
    super.initState();
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    _selected = state.document.animations.firstOrNull?.name;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _frameController.dispose();
    _durationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return const SizedBox();
    final colorScheme = Theme.of(context).colorScheme;
    final animation =
        _selected == null ? null : state.document.getAnimation(_selected!);
    if (animation != null) {
      _durationController.text = animation.duration.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) => Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownMenu<String>(
                        width: 200,
                        inputDecorationTheme:
                            const InputDecorationTheme(filled: true),
                        dropdownMenuEntries: state.document.animations
                            .map((e) => DropdownMenuEntry(
                                  value: e.name,
                                  label: e.name,
                                ))
                            .toList(),
                        onSelected: (value) {
                          setState(() {
                            _selected = value;
                          });
                        },
                        initialSelection: _selected,
                      ),
                      MenuAnchor(
                        builder: (context, controller, child) {
                          return IconButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                          );
                        },
                        menuChildren: [
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.plusLight),
                            onPressed: () {},
                            child: Text(AppLocalizations.of(context).create),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.copyLight),
                            onPressed: animation == null ? null : () {},
                            child: Text(AppLocalizations.of(context).duplicate),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.pencilLight),
                            onPressed: animation == null ? null : () {},
                            child: Text(AppLocalizations.of(context).edit),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.trashLight),
                            onPressed: animation == null ? null : () {},
                            child: Text(AppLocalizations.of(context).delete),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.playLight),
                        onPressed: animation == null ? null : () {},
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.stopLight),
                        onPressed: animation == null ? null : () {},
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.recordLight),
                        onPressed: animation == null ? null : () {},
                      ),
                    ],
                  ),
                  if (animation != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelText: AppLocalizations.of(context).frame,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            controller: _frameController,
                            textAlign: TextAlign.center,
                            onEditingComplete: () {},
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: max(200, constraints.maxWidth * 0.25),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colorScheme.onBackground.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: CustomPaint(
                            painter: PresentationTimelinePainter(
                              animationKeys: animation.keys.keys.toList(),
                              currentFrame: 10,
                              duration: animation.duration,
                              zoom: 1,
                              position: 0,
                              cursorColor: colorScheme.primary,
                              keyColor: colorScheme.secondary,
                              backgroundColor: colorScheme.background,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelText: AppLocalizations.of(context).duration,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            controller: _durationController,
                            textAlign: TextAlign.center,
                            onEditingComplete: () {
                              final value =
                                  int.tryParse(_durationController.text.trim());
                              if (value != null && value > 0) {
                                context.read<DocumentBloc>().add(
                                      DocumentAnimationUpdated(
                                        animation.name,
                                        animation.copyWith(duration: value),
                                      ),
                                    );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        MenuAnchor(
                          builder: (context, controller, child) => IconButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(PhosphorIcons.presentationLight),
                          ),
                          menuChildren: [
                            MenuItemButton(
                              leadingIcon:
                                  const Icon(PhosphorIcons.playCircleLight),
                              child: Text(AppLocalizations.of(context).play),
                            ),
                            const Divider(),
                            MenuItemButton(
                              leadingIcon:
                                  const Icon(PhosphorIcons.videoCameraLight),
                              child: Text(AppLocalizations.of(context).video),
                            ),
                            MenuItemButton(
                              leadingIcon:
                                  const Icon(PhosphorIcons.filmStripLight),
                              child: Text(AppLocalizations.of(context).image),
                            ),
                            MenuItemButton(
                              leadingIcon: const Icon(PhosphorIcons.fileLight),
                              child: Text(AppLocalizations.of(context).pdf),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PresentationTimelinePainter extends CustomPainter {
  final List<int> animationKeys;
  final int currentFrame;
  final int duration;
  final double zoom;
  final double position;
  final Color cursorColor, keyColor, backgroundColor;

  PresentationTimelinePainter({
    required this.animationKeys,
    required this.currentFrame,
    required this.duration,
    required this.zoom,
    required this.position,
    required this.cursorColor,
    required this.keyColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // set zoom relative to duration
    final currentZoom = zoom * size.width / duration;
    canvas.scale(currentZoom, 1);
    canvas.translate(position, 0);
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 1 / currentZoom
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Offset.zero & Size(duration.toDouble(), size.height), backgroundPaint);
    final cursorPaint = Paint()
      ..color = cursorColor
      ..strokeWidth = 1 / currentZoom
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(currentFrame.toDouble(), 0),
        Offset(currentFrame.toDouble(), size.height), cursorPaint);
    final keyPaint = Paint()
      ..color = keyColor
      ..strokeWidth = 1 / currentZoom
      ..style = PaintingStyle.fill;
    for (final key in animationKeys) {
      canvas.drawLine(Offset(key.toDouble(), 0),
          Offset(key.toDouble(), size.height * 0.5), keyPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PresentationTimelinePainter oldDelegate) {
    return oldDelegate.animationKeys != animationKeys ||
        oldDelegate.currentFrame != currentFrame ||
        oldDelegate.duration != duration ||
        oldDelegate.zoom != zoom ||
        oldDelegate.position != position ||
        oldDelegate.cursorColor != cursorColor ||
        oldDelegate.keyColor != keyColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
