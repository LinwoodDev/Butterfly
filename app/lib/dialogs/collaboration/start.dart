import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
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
                  icon: const PhosphorIcon(PhosphorIconsLight.graph),
                  child: Text(AppLocalizations.of(context).webRtc),
                ),
                Tab(
                  icon: const PhosphorIcon(PhosphorIconsLight.plugs),
                  child: Text(AppLocalizations.of(context).webSocket),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
                child: TabBarView(controller: _tabController, children: [
              ListView(
                children: [
                  DropdownMenu(
                    width: 300,
                    label: Text(AppLocalizations.of(context).iceServer),
                    dropdownMenuEntries: context
                        .read<SettingsCubit>()
                        .state
                        .iceServers
                        .map((e) => DropdownMenuEntry(
                              value: e,
                              label: e,
                            ))
                        .toList(),
                  ),
                ],
              ),
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
            final service = state.networkService;
            if (_tabController.index == 0) {
              service.createRtcServer();
            } else {
              service.createSocketServer();
            }
          },
          child: Text(AppLocalizations.of(context).start),
        ),
      ],
    );
  }
}
