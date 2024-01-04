import 'dart:convert';
import 'dart:ui';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/widgets/window.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExperimentsSettingsPage extends StatelessWidget {
  final bool inView;
  const ExperimentsSettingsPage({super.key, this.inView = false});

  List<({String name, String description, IconGetter icon})> _getExperiments(
          BuildContext context) =>
      [
        (
          name: 'collaboration',
          description: AppLocalizations.of(context).collaboration,
          icon: PhosphorIcons.chatTeardrop,
        )
      ];

  static const Map<String, String> _featureHelps = {
    'collaboration': 'collaboration',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: WindowTitleBar(
          title: Text(AppLocalizations.of(context).experiments),
          backgroundColor: inView ? Colors.transparent : null,
          inView: inView,
          actions: [
            IconButton(
              icon:
                  const PhosphorIcon(PhosphorIconsLight.clockCounterClockwise),
              onPressed: () => context.read<SettingsCubit>().resetFlags(),
            ),
          ],
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
            buildWhen: (previous, current) => previous.flags != current.flags,
            builder: (context, state) {
              final experiments = _getExperiments(context);
              if (experiments.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context).noElements),
                );
              }
              return ListView.builder(
                  itemCount: experiments.length,
                  itemBuilder: (context, index) {
                    final experiment = experiments[index];
                    final currentHelp = _featureHelps[experiment.name];
                    final enabled = state.flags.contains(experiment.name);
                    return AdvancedSwitchListTile(
                      value: enabled,
                      onChanged: (value) {
                        final cubit = context.read<SettingsCubit>();
                        if (value == true) {
                          cubit.addFlag(experiment.name);
                        } else {
                          cubit.removeFlag(experiment.name);
                        }
                      },
                      title: Text(experiment.description),
                      leading: PhosphorIcon(
                          experiment.icon(PhosphorIconsStyle.light)),
                      onTap: currentHelp == null
                          ? null
                          : () => openHelp([currentHelp]),
                    );
                  });
            }));
  }
}

class _AddRemoteDialog extends StatefulWidget {
  final ExternalStorageType type;

  const _AddRemoteDialog({required this.type});

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
      _templatesDirectoryController = TextEditingController(text: 'Templates'),
      _packsDirectoryController = TextEditingController(text: 'Packs');
  bool _isConnected = false,
      _advanced = false,
      _showPassword = false,
      _syncRootDirectory = false;

  bool get _isRemote => widget.type != ExternalStorageType.local;

  @override
  void initState() {
    super.initState();
    _isConnected = !_isRemote;
  }

  void _connect() async {
    try {
      final loc = AppLocalizations.of(context);
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
        _showCreatingError(loc.cannotConnect);
        return;
      }
      setState(() => _isConnected = true);
    } catch (e) {
      _showCreatingError(AppLocalizations.of(context).cannotConnect, e);
    }
  }

  Future<Uint8List?> _getIcon() async {
    if (!_isRemote) return null;
    try {
      var url = Uri.tryParse(_iconController.text.trim());

      if (!(url?.isAbsolute ?? true)) {
        url = Uri.tryParse(_urlController.text.trim())
            ?.resolve(_iconController.text.trim());
      }
      if (url == null) {
        return null;
      }

      final response = await http.get(url);
      if (response.statusCode != 200) {
        return null;
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
        _showCreatingError(AppLocalizations.of(context).cannotConnect, e);
      }
    }
    return null;
  }

  Future<void> _create() async {
    final navigator = Navigator.of(context);
    final settingsCubit = context.read<SettingsCubit>();
    final icon = await _getIcon();
    final remoteStorage = switch (widget.type) {
      ExternalStorageType.dav => DavRemoteStorage(
          username: _usernameController.text,
          url: _urlController.text,
          path: _directoryController.text,
          documentsPath: _documentsDirectoryController.text,
          templatesPath: _templatesDirectoryController.text,
          packsPath: _packsDirectoryController.text,
          icon: icon,
          cachedDocuments: [if (_syncRootDirectory) '/']),
      ExternalStorageType.local => LocalStorage(
          path: _directoryController.text,
          documentsPath: _documentsDirectoryController.text,
          templatesPath: _templatesDirectoryController.text,
          packsPath: _packsDirectoryController.text,
          icon: icon,
        ),
    };
    await settingsCubit.addRemote(
      remoteStorage,
      password: _passwordController.text,
    );
    navigator.pop();
  }

  Future<void> _showCreatingError(String error, [dynamic e]) {
    return showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  AppLocalizations.of(context).errorWhileCreatingConnection),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(error),
                  if (e != null)
                    Text(
                      e.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context).ok),
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
              title: Text(AppLocalizations.of(context).addConnection),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView(children: [
                if (_isRemote) ...[
                  TextField(
                    controller: _urlController,
                    readOnly: _isConnected,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).url,
                      filled: true,
                      icon: const PhosphorIcon(PhosphorIconsLight.link),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _iconController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).icon,
                      filled: true,
                      icon: const PhosphorIcon(PhosphorIconsLight.image),
                    ),
                  ),
                  const Divider(
                    height: 32,
                  ),
                ],
                if (!_isConnected) ...[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).username,
                      filled: true,
                      icon: const PhosphorIcon(PhosphorIconsLight.user),
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
                      labelText: AppLocalizations.of(context).password,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: PhosphorIcon(
                          _showPassword
                              ? PhosphorIconsLight.eye
                              : PhosphorIconsLight.eyeSlash,
                        ),
                        tooltip: _showPassword
                            ? AppLocalizations.of(context).hide
                            : AppLocalizations.of(context).show,
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      ),
                      icon: const PhosphorIcon(PhosphorIconsLight.lock),
                    ),
                  ),
                  CheckboxListTile(
                    value: _syncRootDirectory,
                    onChanged: (value) => setState(
                        () => _syncRootDirectory = value ?? _syncRootDirectory),
                    title: Text(AppLocalizations.of(context).syncRootDirectory),
                  ),
                ] else ...[
                  _DirectoryField(
                    controller: _directoryController,
                    label: AppLocalizations.of(context).directory,
                    icon: const PhosphorIcon(PhosphorIconsLight.folder),
                    readOnly: !_isRemote,
                    onTap: _isRemote
                        ? null
                        : () async {
                            final result = await getDirectoryPath();
                            if (result != null) {
                              _directoryController.text = result;
                            }
                          },
                  ),
                  const SizedBox(height: 8),
                  ExpansionPanelList(
                    expansionCallback: (index, isExpanded) =>
                        setState(() => _advanced = isExpanded),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) => ListTile(
                          title: Text(AppLocalizations.of(context).advanced),
                        ),
                        canTapOnHeader: true,
                        isExpanded: _advanced,
                        body: Column(children: [
                          _DirectoryField(
                            controller: _documentsDirectoryController,
                            label:
                                AppLocalizations.of(context).documentsDirectory,
                            icon: const PhosphorIcon(PhosphorIconsLight.file),
                          ),
                          const SizedBox(height: 8),
                          _DirectoryField(
                            controller: _templatesDirectoryController,
                            label:
                                AppLocalizations.of(context).templatesDirectory,
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.fileDashed),
                          ),
                          const SizedBox(height: 8),
                          _DirectoryField(
                            controller: _packsDirectoryController,
                            label: AppLocalizations.of(context).packsDirectory,
                            icon:
                                const PhosphorIcon(PhosphorIconsLight.package),
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
                    if (_isConnected && _isRemote) {
                      setState(() => _isConnected = false);
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).cancel),
                ),
                if (_isConnected) ...[
                  ElevatedButton(
                    onPressed: _create,
                    child: Text(AppLocalizations.of(context).create),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: _connect,
                    child: Text(AppLocalizations.of(context).connect),
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
  final VoidCallback? onTap;
  final bool readOnly;

  const _DirectoryField({
    this.controller,
    this.label,
    this.onTap,
    this.readOnly = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        icon: icon,
        filled: true,
        /*suffixIcon: IconButton(
            icon: PhosphorIcon(PhosphorIconsLight.folder),
            onPressed: () async {}),*/
      ),
      onTap: onTap,
    );
  }
}
