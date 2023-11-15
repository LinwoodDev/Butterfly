import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartCollaborationDialog extends StatefulWidget {
  const StartCollaborationDialog({super.key});

  @override
  State<StartCollaborationDialog> createState() =>
      _StartCollaborationDialogState();
}

class _StartCollaborationDialogState extends State<StartCollaborationDialog>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      content: SizedBox(
        width: 300,
        height: 150,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  icon: const PhosphorIcon(PhosphorIconsLight.gear),
                  child: Text(AppLocalizations.of(context).settings),
                ),
                Tab(
                  icon: const PhosphorIcon(PhosphorIconsLight.plugs),
                  child: Text(AppLocalizations.of(context).users),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
                child: TabBarView(controller: _tabController, children: [
              kIsWeb
                  ? Text(AppLocalizations.of(context).webNotSupported)
                  : ListView(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context).port),
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
            ])),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
        ElevatedButton(
          onPressed: () {
            final bloc = context.read<DocumentBloc>();
            final state = bloc.state;
            if (state is! DocumentLoaded) return;
            Navigator.of(context).pop();
            state.networkingService.createSocketServer();
          },
          child: Text(AppLocalizations.of(context).start),
        ),
      ],
    );
  }
}
