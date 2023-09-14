import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/collaboration/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartCollaborationDialog extends StatelessWidget {
  const StartCollaborationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      content: DefaultTabController(
        length: 2,
        child: SizedBox(
          width: 300,
          height: 150,
          child: Column(
            children: [
              TabBar(
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
                  child: TabBarView(children: [
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const ViewCollaborationDialog());
          },
          child: Text(AppLocalizations.of(context).start),
        ),
      ],
    );
  }
}
