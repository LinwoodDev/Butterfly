part of 'dialog.dart';

class StartCollaborationDialog extends StatefulWidget {
  final NetworkingService service;

  const StartCollaborationDialog({super.key, required this.service});

  @override
  State<StartCollaborationDialog> createState() =>
      _StartCollaborationDialogState();
}

class _StartCollaborationDialogState extends State<StartCollaborationDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  ConnectionTechnology _connectionTechnology = ConnectionTechnology.swamp;
  late final SettingsCubit _settingsCubit;
  late String _defaultSwamp;
  final TextEditingController _webSocketAddressController =
          TextEditingController(text: '0.0.0.0'),
      _webSocketPortController = TextEditingController(
        text: kDefaultPort.toString(),
      );
  late final TextEditingController _swampAddressController;
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _defaultSwamp = _settingsCubit.state.swamps.firstOrNull ?? '';
    _swampAddressController = TextEditingController(text: _defaultSwamp);
  }

  Future<void> _start() async {
    setState(() => _isStarting = true);
    try {
      switch (_connectionTechnology) {
        case ConnectionTechnology.swamp:
          final swamp = _swampAddressController.text.trim();
          final uri = Uri.tryParse(swamp);
          if (uri == null) return;
          await widget.service.createSwampServer(uri);
          if (swamp != _defaultSwamp) {
            await _settingsCubit.changeSwamp(swamp);
            _defaultSwamp = swamp;
          }
        case ConnectionTechnology.webSocket:
          await widget.service.createSocketServer(
            _webSocketAddressController.text.trim(),
            int.parse(_webSocketPortController.text),
          );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context).error}: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }

  @override
  void dispose() {
    _webSocketAddressController.dispose();
    _webSocketPortController.dispose();
    _swampAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: DefaultTabController(
        length: 2,
        child: ResponsiveAlertDialog(
          title: Text(AppLocalizations.of(context).collaboration),
          leading: IconButton.outlined(
            onPressed: _isStarting ? null : () => Navigator.pop(context),
            icon: Icon(PhosphorIconsLight.x),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          ),
          headerActions: [
            IconButton(
              icon: const Icon(PhosphorIconsLight.sealQuestion),
              onPressed: () {
                openHelp(['collaboration']);
              },
              tooltip: AppLocalizations.of(context).help,
            ),
          ],
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          content: ListView(
            children: [
              DropdownMenu<ConnectionTechnology>(
                expandedInsets: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ),
                label: Text(AppLocalizations.of(context).collaboration),
                initialSelection: _connectionTechnology,
                onSelected: (value) {
                  if (value == null || _isStarting) return;
                  setState(() {
                    _connectionTechnology = value;
                  });
                },
                dropdownMenuEntries: ConnectionTechnology.values
                    .map(
                      (e) => DropdownMenuEntry(
                        label: switch (e) {
                          ConnectionTechnology.swamp => 'Swamp',
                          ConnectionTechnology.webSocket => AppLocalizations.of(
                            context,
                          ).webSocket,
                        },
                        value: e,
                        leadingIcon: Icon(switch (e) {
                          ConnectionTechnology.swamp =>
                            PhosphorIconsLight.globe,
                          ConnectionTechnology.webSocket =>
                            PhosphorIconsLight.wifiHigh,
                        }),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const PhosphorIcon(PhosphorIconsLight.info),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context).information,
                              style: TextTheme.of(context).bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(switch (_connectionTechnology) {
                        ConnectionTechnology.swamp => AppLocalizations.of(
                          context,
                        ).swampDescription,
                        ConnectionTechnology.webSocket => AppLocalizations.of(
                          context,
                        ).webSocketDescription,
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (_connectionTechnology == ConnectionTechnology.swamp)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).address,
                    hintText: 'example.com',
                    filled: true,
                  ),
                  controller: _swampAddressController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return LeapLocalizations.of(context).shouldNotEmpty;
                    }
                    final uri = Uri.tryParse(value!);
                    if (uri == null) {
                      return AppLocalizations.of(context).urlNotValid;
                    }
                    return null;
                  },
                )
              else
                kIsWeb
                    ? Text(
                        AppLocalizations.of(context).webNotSupported,
                        textAlign: TextAlign.center,
                      )
                    : ExpansionPanelList.radio(
                        children: [
                          ExpansionPanelRadio(
                            value: 0,
                            canTapOnHeader: true,
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                title: Text(
                                  AppLocalizations.of(context).advanced,
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  kIsWeb
                                      ? Text(
                                          AppLocalizations.of(context)
                                              .webNotSupported,
                                        )
                                      : Column(
                                          children: [
                                            TextFormField(
                                              decoration: InputDecoration(
                                                labelText: AppLocalizations.of(
                                                  context,
                                                ).address,
                                                hintText: '0.0.0.0',
                                                filled: true,
                                              ),
                                              controller:
                                                  _webSocketAddressController,
                                              validator: (value) {
                                                if (value?.isEmpty ?? true) {
                                                  return LeapLocalizations.of(
                                                    context,
                                                  ).shouldNotEmpty;
                                                }
                                                final address =
                                                    InternetAddress.tryParse(
                                                      value!,
                                                    );
                                                if (address == null) {
                                                  return AppLocalizations.of(
                                                    context,
                                                  ).urlNotValid;
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                labelText: AppLocalizations.of(
                                                  context,
                                                ).port,
                                                hintText: kDefaultPort
                                                    .toString(),
                                                filled: true,
                                              ),
                                              controller:
                                                  _webSocketPortController,
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value?.isEmpty ?? true) {
                                                  return LeapLocalizations.of(
                                                    context,
                                                  ).shouldNotEmpty;
                                                }
                                                final number = int.tryParse(
                                                  value!,
                                                );
                                                if (number == null) {
                                                  return AppLocalizations.of(
                                                    context,
                                                  ).shouldANumber;
                                                }
                                                if (number < 1 ||
                                                    number > 65535) {
                                                  return AppLocalizations.of(
                                                    context,
                                                  ).shouldANumber;
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
            ],
          ),
          actions: [
            ElevatedButton.icon(
              onPressed:
                  _isStarting ||
                      (kIsWeb &&
                          _connectionTechnology ==
                              ConnectionTechnology.webSocket)
                  ? null
                  : () {
                      if (!(_formKey.currentState?.validate() ?? false)) return;
                      _start();
                    },
              icon: _isStarting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(PhosphorIconsLight.play),
              label: Text(
                _isStarting
                    ? AppLocalizations.of(context).loading
                    : AppLocalizations.of(context).start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
