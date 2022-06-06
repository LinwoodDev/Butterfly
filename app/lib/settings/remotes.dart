import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/header.dart';

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
            if (!inView && !kIsWeb && isWindow()) ...[
              const VerticalDivider(),
              const WindowButtons()
            ]
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog(
              context: context, builder: (context) => const _AddRemoteDialog()),
          label: Text(AppLocalizations.of(context)!.addRemote),
          icon: const Icon(PhosphorIcons.plusLight),
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

class _AddRemoteDialog extends StatefulWidget {
  const _AddRemoteDialog();

  @override
  State<_AddRemoteDialog> createState() => __AddRemoteDialogState();
}

class __AddRemoteDialogState extends State<_AddRemoteDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(children: [
            Header(
              title: Text(AppLocalizations.of(context)!.addRemote),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView(children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.name),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _urlController,
                  readOnly: _isConnected,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.url),
                ),
                const Divider(
                  height: 32,
                ),
                if (!_isConnected) ...[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.username),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password),
                  ),
                ]
              ]),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (_isConnected) {
                      setState(() => _isConnected = false);
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                if (_isConnected) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.create),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _isConnected = true);
                    },
                    child: Text(AppLocalizations.of(context)!.connect),
                  ),
                ]
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
