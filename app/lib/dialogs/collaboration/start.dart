part of 'dialog.dart';

class StartCollaborationDialog extends StatefulWidget {
  final NetworkingService service;

  const StartCollaborationDialog({super.key, required this.service});

  @override
  State<StartCollaborationDialog> createState() =>
      _StartCollaborationDialogState();
}

class _StartCollaborationDialogState extends State<StartCollaborationDialog>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TabController _tabController;
  final TextEditingController _webSocketAddressController =
          TextEditingController(text: '0.0.0.0'),
      _webSocketPortController =
          TextEditingController(text: kDefaultPort.toString()),
      _swampAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _start() {
    if (kIsWeb) return;
    if (_tabController.index == 0) {
      widget.service.createSwampServer(Uri.parse(_swampAddressController.text));
      return;
    }
    widget.service.createSocketServer(_webSocketAddressController.text,
        int.tryParse(_webSocketPortController.text));
  }

  @override
  void dispose() {
    super.dispose();
    _webSocketAddressController.dispose();
    _webSocketPortController.dispose();
    _swampAddressController.dispose();
    _tabController.dispose();
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
            onPressed: () => Navigator.pop(context),
            icon: Icon(PhosphorIconsLight.x),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          ),
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          content: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  HorizontalTab(
                    label: const Text('Swamp'),
                    icon: Icon(PhosphorIconsLight.globe),
                  ),
                  HorizontalTab(
                    label: Text(AppLocalizations.of(context).webSocket),
                    icon: Icon(PhosphorIconsLight.wifiHigh),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).address,
                            hintText: 'example.com',
                            filled: true,
                          ),
                          controller: _swampAddressController,
                        ),
                      ],
                    ),
                    kIsWeb
                        ? Text(AppLocalizations.of(context).webNotSupported)
                        : Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context).address,
                                  hintText: '0.0.0.0',
                                  filled: true,
                                ),
                                controller: _webSocketAddressController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return LeapLocalizations.of(context)
                                        .shouldNotEmpty;
                                  }
                                  final address =
                                      InternetAddress.tryParse(value!);
                                  if (address == null) {
                                    return AppLocalizations.of(context)
                                        .urlNotValid;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).port,
                                  hintText: kDefaultPort.toString(),
                                  filled: true,
                                ),
                                controller: _webSocketPortController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return LeapLocalizations.of(context)
                                        .shouldNotEmpty;
                                  }
                                  final number = int.tryParse(value!);
                                  if (number == null) {
                                    return AppLocalizations.of(context)
                                        .shouldANumber;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: kIsWeb
                  ? null
                  : () {
                      if (!(_formKey.currentState?.validate() ?? false)) return;
                      _start();
                    },
              icon: Icon(PhosphorIconsLight.play),
              label: Text(AppLocalizations.of(context).start),
            ),
          ],
        ),
      ),
    );
  }
}
