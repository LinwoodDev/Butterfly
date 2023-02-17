import 'dart:math';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) return Container();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
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
                      DropdownMenu(
                        width: 200,
                        inputDecorationTheme:
                            const InputDecorationTheme(filled: true),
                        dropdownMenuEntries: ['Animation 1', 'Animation 2']
                            .map((e) => DropdownMenuEntry(
                                  value: e,
                                  label: e,
                                ))
                            .toList(),
                        onSelected: (value) {},
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
                            leadingIcon: const Icon(PhosphorIcons.copyLight),
                            onPressed: () {},
                            child: Text(AppLocalizations.of(context).duplicate),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.pencilLight),
                            onPressed: () {},
                            child: Text(AppLocalizations.of(context).edit),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.trashLight),
                            onPressed: () {},
                            child: Text(AppLocalizations.of(context).delete),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.playLight),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.stopLight),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.recordLight),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 50,
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                          ),
                          textAlign: TextAlign.center,
                          onEditingComplete: () {},
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: max(200, constraints.maxWidth * 0.25),
                        child: Slider(
                          value: 50,
                          min: 0,
                          max: 100,
                          onChanged: (value) {},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.presentationLight),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
