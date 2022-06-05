import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RemotesSettingsPage extends StatelessWidget {
  final bool inView;
  const RemotesSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.remotes),
          backgroundColor: inView ? Colors.transparent : null,
          automaticallyImplyLeading: !inView,
          actions: [
            IconButton(
              icon: const Icon(PhosphorIcons.plusLight),
              onPressed: () {},
            ),
            if (!inView && !kIsWeb && isWindow()) ...[
              const VerticalDivider(),
              const WindowButtons()
            ]
          ],
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
            buildWhen: (previous, current) =>
                previous.inputType == current.inputType,
            builder: (context, state) {
              if (state.remotes.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.noRemotes),
                );
              }
              return ListView.builder(
                  itemCount: state.remotes.length,
                  itemBuilder: (context, index) {
                    final remote = state.remotes[index];
                    return ListTile(
                      title: Text(remote.name),
                      subtitle: Text(remote.url),
                      leading: remote.icon != null
                          ? Image.memory(remote.icon!)
                          : const Icon(PhosphorIcons.cloudFill),
                    );
                  });
            }));
  }
}
