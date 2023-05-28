import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../dialogs/delete.dart';
import '../widgets/menu.dart';

class PagesView extends StatelessWidget {
  const PagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        final currentName = state.pageName;
        final current = state.page;
        return StreamBuilder<NoteData>(
            stream: state.data.onChange,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              final pages = snapshot.data!.getPages();
              return Stack(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final page = pages[index];
                        return ListTile(
                          title: Text(page),
                          selected: page == currentName,
                          onTap: () => context
                              .read<DocumentBloc>()
                              .add(PageChanged(page)),
                          trailing: MenuAnchor(
                            builder: defaultMenuButton(),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.trash),
                                onPressed: currentName == page
                                    ? null
                                    : () async {
                                        final result = await showDialog<bool>(
                                            context: context,
                                            builder: (context) =>
                                                const DeleteDialog());
                                        if (result != true) return;
                                        snapshot.data?.removePage(page);
                                      },
                                child:
                                    Text(AppLocalizations.of(context).delete),
                              )
                            ],
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton.extended(
                          label: Text(AppLocalizations.of(context).create),
                          icon: const PhosphorIcon(PhosphorIconsLight.plus),
                          onPressed: () async {
                            final name = await showDialog<String>(
                                context: context,
                                builder: (context) => NameDialog(
                                    validator:
                                        defaultNameValidator(context, pages)));
                            if (name == null) return;
                            snapshot.data?.setPage(
                              DocumentPage(
                                background: current.background,
                              ),
                              name,
                            );
                          }),
                    ),
                  )
                ],
              );
            });
      },
    );
  }
}
