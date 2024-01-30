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
  late final TabController _tabController;
  final GlobalKey<FormState> _socketFormKey = GlobalKey();
  final TextEditingController _addressController =
          TextEditingController(text: '0.0.0.0'),
      _portController = TextEditingController(text: kDefaultPort.toString());

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _addressController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      content: SizedBox(
        width: 600,
        height: 400,
        child: Column(
          children: [
            TabBar(
              tabs: [
                const Tab(text: 'S5'),
                Tab(text: AppLocalizations.of(context).webSocket),
              ],
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const SizedBox(),
                  Form(
                    key: _socketFormKey,
                    child: kIsWeb
                        ? Text(AppLocalizations.of(context).webNotSupported)
                        : ListView(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context).address,
                                  hintText: '0.0.0.0',
                                  filled: true,
                                ),
                                controller: _addressController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)
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
                                controller: _portController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
        ListenableBuilder(
          listenable: _tabController,
          builder: (context, _) => ElevatedButton(
            onPressed: _tabController.index == 0
                ? () {
                    Navigator.of(context).pop();
                    widget.service.createS5();
                  }
                : kIsWeb
                    ? null
                    : () {
                        if (!(_socketFormKey.currentState?.validate() ??
                            false)) {
                          return;
                        }
                        Navigator.of(context).pop();
                        widget.service.createSocketServer(
                            _addressController.text,
                            int.tryParse(_portController.text));
                      },
            child: Text(AppLocalizations.of(context).start),
          ),
        ),
      ],
    );
  }
}
