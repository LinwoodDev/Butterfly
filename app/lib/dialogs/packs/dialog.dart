import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/header.dart';
import 'create.dart';

class PacksDialog extends StatefulWidget {
  const PacksDialog({super.key});

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Stack(children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Header(
              title: Text(AppLocalizations.of(context)!.packs),
            ),
            TabBar(
              controller: _controller,
              tabs: [
                Tab(
                  icon: const Icon(PhosphorIcons.fileLight),
                  text: AppLocalizations.of(context)!.document,
                ),
                Tab(
                  icon: const Icon(PhosphorIcons.appWindowLight),
                  text: AppLocalizations.of(context)!.local,
                ),
              ],
            ),
            Flexible(
              child: BlocBuilder<DocumentBloc, DocumentState>(
                  builder: (context, state) {
                if (state is! DocumentLoadSuccess) return Container();
                final packs = state.document.packs;
                return TabBarView(controller: _controller, children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: packs.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(packs[index].name),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: packs.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(packs[index].name),
                    ),
                  ),
                ]);
              }),
            ),
          ]),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                child: const Icon(PhosphorIcons.plusLight),
                onPressed: () {
                  showModalBottomSheet<ThemeMode>(
                    context: context,
                    builder: (context) => Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ListView(shrinkWrap: true, children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Text(
                            AppLocalizations.of(context)!.add,
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.import),
                          leading: const Icon(PhosphorIcons.arrowSquareInLight),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.create),
                          leading: const Icon(PhosphorIcons.plusCircleLight),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => const CreatePackDialog(),
                            );
                          },
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
