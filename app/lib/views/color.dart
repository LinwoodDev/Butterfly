import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../cubits/settings.dart';
import '../dialogs/color_pick.dart';

class ColorView extends StatefulWidget {
  const ColorView({super.key});

  @override
  State<ColorView> createState() => _ColorViewState();
}

class _ColorViewState extends State<ColorView> {
  String? currentPalette;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _animatedKey = GlobalKey();
  double _height = 50;

  void _setOpened(bool opened) {
    if (opened && _height == 0) {
      _height = 50;
    }
    if (!opened && _height != 0) {
      _height = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.colorEnabled != current.colorEnabled,
        builder: (context, settings) {
          return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
            builder: (context, currentIndex) =>
                BlocBuilder<DocumentBloc, DocumentState>(
                    builder: (context, state) {
              Widget? child;
              if (!settings.colorEnabled) {
                _setOpened(false);
              } else if (state is! DocumentLoadSuccess) {
                _setOpened(false);
              } else {
                final painter = currentIndex.handler;
                final bloc = context.read<DocumentBloc>();
                final color = painter?.getColor(bloc);
                if (color == null) {
                  _setOpened(false);
                } else {
                  currentPalette ??= state.document.palettes.firstOrNull?.name;
                  final palette = currentPalette == null
                      ? null
                      : state.document.getPalette(currentPalette!);
                  _setOpened(true);
                  child = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!(palette?.colors.contains(color) ?? false)) ...[
                        _ColorButton(
                            current: color,
                            color: color,
                            bloc: bloc,
                            painterIndex: currentIndex.index),
                        const VerticalDivider(),
                      ],
                      Expanded(
                          child: Scrollbar(
                        controller: _scrollController,
                        child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: palette?.colors.length ?? 0,
                            itemBuilder: (context, index) {
                              final current = palette?.colors[index];
                              if (current == null) return Container();
                              return _ColorButton(
                                  bloc: bloc,
                                  painterIndex: currentIndex.index,
                                  color: color,
                                  current: current,
                                  handler: painter);
                            }),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(PhosphorIcons.penLight),
                            onPressed: () async {
                              final nextColor = await showDialog(
                                  context: context,
                                  builder: (context) => CustomColorPicker(
                                      defaultColor: Color(color))) as int?;
                              if (nextColor != null) {
                                final newPainter =
                                    painter?.setColor(bloc, nextColor);
                                if (newPainter == null) return;
                                bloc.add(PainterChanged(
                                    newPainter, currentIndex.index));
                              }
                            },
                          ),
                          if (state.document.palettes.length > 1)
                            PopupMenuButton(
                              icon: const Icon(PhosphorIcons.listLight),
                              itemBuilder: (context) => [
                                for (final palette in state.document.palettes)
                                  PopupMenuItem(
                                    value: palette.name,
                                    textStyle: palette.name == currentPalette
                                        ? Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                        : null,
                                    child: Text(palette.name),
                                    onTap: () {
                                      setState(() {
                                        currentPalette = palette.name;
                                      });
                                    },
                                  ),
                              ],
                            )
                        ],
                      )
                    ],
                  );
                }
              }
              return AnimatedContainer(
                height: _height,
                key: _animatedKey,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 200),
                child: child,
              );
            }),
          );
        });
  }
}

class _ColorButton extends StatelessWidget {
  final Handler? handler;
  final int current, color;
  final DocumentBloc bloc;
  final int painterIndex;
  const _ColorButton(
      {this.handler,
      required this.current,
      required this.color,
      required this.bloc,
      required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          final newPainter = handler?.setColor(bloc, current);
          if (newPainter == null) return;
          context
              .read<DocumentBloc>()
              .add(PainterChanged(newPainter, painterIndex));
        },
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(current),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color == current
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
