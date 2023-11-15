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
  final TextEditingController _connectUrlController = TextEditingController(),
      _createPortController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _connectUrlController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _connect() {
    var uri = Uri.parse(_connectUrlController.text);
    widget.service.createSocketClient(uri);
  }

  void _start() {
    if (kIsWeb) return;
    widget.service.createSocketServer(int.tryParse(_createPortController.text));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context).collaboration),
        content: SizedBox(
          width: 300,
          height: 150,
          child: Column(children: [
            TabBar(
              controller: _tabController,
              tabs: [
                HorizontalTab(
                    label: Text(AppLocalizations.of(context).client),
                    icon: const PhosphorIcon(PhosphorIconsLight.plugs)),
                HorizontalTab(
                    label: Text(AppLocalizations.of(context).server),
                    icon: const PhosphorIcon(PhosphorIconsLight.database)),
              ],
            ),
            const SizedBox(height: 16),
            TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context).url),
                        filled: true,
                      ),
                      controller: _connectUrlController,
                      keyboardType: TextInputType.url,
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
                            controller: _createPortController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
              ],
            ),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).close),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (_tabController.index == 0) {
                _connect();
              } else {
                _start();
              }
            },
            child: Text(AppLocalizations.of(context).start),
          ),
        ],
      ),
    );
  }
}
