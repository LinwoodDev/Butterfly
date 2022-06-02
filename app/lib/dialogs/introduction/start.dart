import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/format_date_time.dart';
import '../../cubits/settings.dart';

class StartIntroductionDialog extends StatelessWidget {
  const StartIntroductionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(width: 800, height: 600),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                AppLocalizations.of(context)!.start,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 16),
              Flexible(
                  child: isMobile
                      ? Column(
                          children: [
                            const Flexible(child: _CreateStartView()),
                            const SizedBox(height: 16),
                            Flexible(child: _RecentStartView()),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                              const Flexible(child: _CreateStartView()),
                              const SizedBox(height: 16),
                              Flexible(child: _RecentStartView()),
                            ])),
            ]);
          }),
        ),
      ),
    );
  }
}

class _CreateStartView extends StatefulWidget {
  const _CreateStartView();

  @override
  State<_CreateStartView> createState() => _CreateStartViewState();
}

class _CreateStartViewState extends State<_CreateStartView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final templateSystem = TemplateFileSystem.fromPlatform();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.create,
              style: Theme.of(context).textTheme.headline6,
            ),
            Flexible(
              child: FutureBuilder<List<DocumentTemplate>>(
                future: templateSystem
                    .createDefault(context)
                    .then((_) => templateSystem.getTemplates()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ListView(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.error,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          snapshot.error.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        OutlinedButton.icon(
                          label: Text(
                              AppLocalizations.of(context)!.defaultTemplate),
                          icon: const Icon(
                              PhosphorIcons.clockCounterClockwiseLight),
                          onPressed: () async {
                            await templateSystem.createDefault(context,
                                force: true);
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final template = snapshot.data![index];
                        return ListTile(
                            title: Text(template.name),
                            subtitle: Text(template.description),
                            onTap: () async {
                              final settingsCubit =
                                  context.read<SettingsCubit>();
                              final currentIndexCubit =
                                  context.read<CurrentIndexCubit>();
                              final bloc = context.read<DocumentBloc>();
                              final transformCubit =
                                  context.read<TransformCubit>();
                              Navigator.of(context).pop();
                              final settings = settingsCubit.state;
                              final document = template.document.copyWith(
                                name: await formatCurrentDateTime(
                                    settings.locale),
                                createdAt: DateTime.now(),
                              );

                              bloc.clearHistory();
                              transformCubit.reset();
                              currentIndexCubit.reset();
                              bloc.emit(DocumentLoadSuccess(document,
                                  currentIndexCubit: currentIndexCubit,
                                  settingsCubit: settingsCubit));
                            });
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentStartView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  _RecentStartView();

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final recents = settingsCubit.state.recentHistory;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.recentFiles,
              style: Theme.of(context).textTheme.headline6,
            ),
            Flexible(
              child: recents.isEmpty
                  ? Center(
                      child: Text(
                      AppLocalizations.of(context)!.noRecentFiles,
                      style: Theme.of(context).textTheme.bodyText2,
                    ))
                  : ListView(
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: const ScrollPhysics(),
                      children: recents.map((recent) {
                        return Dismissible(
                          key: Key(recent),
                          onDismissed: (direction) {
                            settingsCubit.removeRecentHistory(recent);
                          },
                          child: ListTile(
                              title: Text(recent),
                              onTap: () {
                                GoRouter.of(context).pushNamed('home',
                                    queryParams: {'path': recent});
                              }),
                        );
                      }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
