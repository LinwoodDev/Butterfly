import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
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
            IconButton(
                icon: const Icon(PhosphorIcons.circleWavyQuestionLight),
                onPressed: () => openHelp(['storage'], 'remote')),
            BlocBuilder<SettingsCubit, ButterflySettings>(
                builder: (context, settings) {
              return IconButton(
                icon: settings.defaultRemote.isEmpty
                    ? const Icon(PhosphorIcons.houseFill)
                    : const Icon(PhosphorIcons.houseLight),
                onPressed: () {
                  BlocProvider.of<SettingsCubit>(context).setDefaultRemote('');
                },
              );
            }),
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
        body: Builder(builder: (context) {
          if (kIsWeb) {
            return Center(
                child: Text(AppLocalizations.of(context)!.webNotSupported));
          }
          return BlocBuilder<SettingsCubit, ButterflySettings>(
              builder: (context, state) {
            if (state.remotes.isEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noRemotes),
              );
            }
            return Material(
              child: ListView.builder(
                  itemCount: state.remotes.length,
                  itemBuilder: (context, index) {
                    final remote = state.remotes[index];
                    return Dismissible(
                      key: Key(remote.identifier),
                      onDismissed: (details) {
                        BlocProvider.of<SettingsCubit>(context)
                            .deleteRemote(remote.identifier);
                      },
                      child: ListTile(
                        title: Text(remote.identifier),
                        leading: remote.icon.isEmpty
                            ? null
                            : Image.memory(remote.icon),
                        onTap: () {
                          GoRouter.of(context).push(
                              '/settings/remotes/${Uri.encodeComponent(remote.identifier)}');
                        },
                        trailing: IconButton(
                          icon: remote.identifier == state.defaultRemote
                              ? const Icon(PhosphorIcons.cloudFill)
                              : const Icon(PhosphorIcons.cloudLight),
                          onPressed: () {
                            BlocProvider.of<SettingsCubit>(context)
                                .setDefaultRemote(remote.identifier);
                          },
                        ),
                      ),
                    );
                  }),
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
  final TextEditingController _urlController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _iconController = TextEditingController(text: '/favicon.ico'),
      _directoryController = TextEditingController(),
      _documentsDirectoryController = TextEditingController(text: 'Documents'),
      _templatesDirectoryController = TextEditingController(text: 'Templates');
  bool _isConnected = false,
      _advanced = false,
      _showPassword = false,
      _syncRootDirectory = false;

  void _connect() async {
    try {
      final loc = AppLocalizations.of(context)!;
      final url = Uri.tryParse(_urlController.text.trim());
      if (_urlController.text.isEmpty || url == null) {
        _showCreatingError(loc.urlNotValid);
        return;
      }
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('${_usernameController.text}:${_passwordController.text}'))}',
      });
      if (response.statusCode != 200) {
        _showCreatingError(loc.cannotConnectToRemote);
        return;
      }
      setState(() => _isConnected = true);
    } catch (e) {
      _showCreatingError(
          AppLocalizations.of(context)!.cannotConnectToRemote, e);
    }
  }

  Future<Uint8List> _getIcon() async {
    try {
      var url = Uri.tryParse(_iconController.text.trim());

      if (!(url?.isAbsolute ?? true)) {
        url = Uri.tryParse(_urlController.text.trim())
            ?.resolve(_iconController.text.trim());
      }
      if (url == null) {
        return Uint8List(0);
      }

      final response = await http.get(url);
      if (response.statusCode != 200) {
        return Uint8List(0);
      }
      try {
        final image = await decodeImageFromList(response.bodyBytes);
        final imageBytes = (await image.toByteData(format: ImageByteFormat.png))
            ?.buffer
            .asUint8List();
        if (imageBytes?.isNotEmpty ?? false) {
          return imageBytes!;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        _showCreatingError(
            AppLocalizations.of(context)!.cannotConnectToRemote, e);
      }
    }
    return Uint8List(0);
  }

  Future<void> _create() async {
    final navigator = Navigator.of(context);
    final settingsCubit = context.read<SettingsCubit>();
    final icon = await _getIcon();
    final remoteStorage = DavRemoteStorage(
        username: _usernameController.text,
        url: _urlController.text,
        path: _directoryController.text,
        documentsPath: _documentsDirectoryController.text,
        templatesPath: _templatesDirectoryController.text,
        icon: icon,
        cachedDocuments: [if (_syncRootDirectory) '/']);
    await settingsCubit.addRemote(
      remoteStorage,
      password: _passwordController.text,
    );
    navigator.pop();
  }

  void _showCreatingError(String error, [dynamic e]) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:
                  Text(AppLocalizations.of(context)!.errorWhileCreatingRemote),
              content: Column(
                children: [
                  Text(error),
                  if (e != null)
                    Text(
                      e.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
              ],
            ));
  }

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
                  controller: _urlController,
                  readOnly: _isConnected,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.url,
                    icon: const Icon(PhosphorIcons.linkLight),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _iconController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.icon,
                    icon: const Icon(PhosphorIcons.imageLight),
                  ),
                ),
                const Divider(
                  height: 32,
                ),
                if (!_isConnected) ...[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.username,
                      icon: const Icon(PhosphorIcons.userLight),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    keyboardType: _showPassword
                        ? TextInputType.visiblePassword
                        : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.password,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? PhosphorIcons.eyeLight
                              : PhosphorIcons.eyeSlashLight,
                        ),
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      ),
                      icon: const Icon(PhosphorIcons.lockLight),
                    ),
                  ),
                ] else ...[
                  CheckboxListTile(
                    value: _syncRootDirectory,
                    onChanged: (value) => setState(
                        () => _syncRootDirectory = value ?? _syncRootDirectory),
                    title:
                        Text(AppLocalizations.of(context)!.syncRootDirectory),
                  ),
                  _DirectoryField(
                    controller: _directoryController,
                    label: AppLocalizations.of(context)!.directory,
                    onChanged: (value) {
                      var prefix = value;
                      if (prefix.isNotEmpty) {
                        prefix += '/';
                      }
                      _documentsDirectoryController.text = '${prefix}Documents';
                      _templatesDirectoryController.text = '${prefix}Templates';
                    },
                    icon: const Icon(PhosphorIcons.folderLight),
                  ),
                  const SizedBox(height: 8),
                  ExpansionPanelList(
                    expansionCallback: (index, isExpanded) =>
                        setState(() => _advanced = !isExpanded),
                    children: [
                      ExpansionPanel(
                        headerBuilder: ((context, isExpanded) => Align(
                              alignment: Alignment.center,
                              child: Text(
                                  AppLocalizations.of(context)!.advanced,
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.center),
                            )),
                        canTapOnHeader: true,
                        isExpanded: _advanced,
                        body: Column(children: [
                          _DirectoryField(
                            controller: _documentsDirectoryController,
                            label: AppLocalizations.of(context)!
                                .documentsDirectory,
                            icon: const Icon(PhosphorIcons.fileLight),
                          ),
                          const SizedBox(height: 8),
                          _DirectoryField(
                            controller: _templatesDirectoryController,
                            label: AppLocalizations.of(context)!
                                .templatesDirectory,
                            icon: const Icon(PhosphorIcons.fileDottedLight),
                          ),
                        ]),
                      ),
                    ],
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
                    onPressed: _create,
                    child: Text(AppLocalizations.of(context)!.create),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: _connect,
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

class _DirectoryField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final Widget? icon;
  final ValueChanged<String>? onChanged;
  const _DirectoryField(
      {this.controller, this.label, this.onChanged, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        icon: icon,
        /*suffixIcon: IconButton(
            icon: const Icon(PhosphorIcons.folderLight),
            onPressed: () async {}),*/
      ),
      onChanged: onChanged,
    );
  }
}
