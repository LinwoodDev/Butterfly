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
  final TextEditingController _addressController =
          TextEditingController(text: '0.0.0.0'),
      _portController = TextEditingController(text: kDefaultPort.toString());

  void _start() {
    if (kIsWeb) return;
    widget.service.createSocketServer(
        _addressController.text, int.tryParse(_portController.text));
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _portController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: DefaultTabController(
        length: 2,
        child: AlertDialog(
          title: Text(AppLocalizations.of(context).collaboration),
          scrollable: true,
          content: kIsWeb
              ? Text(AppLocalizations.of(context).webNotSupported)
              : Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).address,
                        hintText: '0.0.0.0',
                        filled: true,
                      ),
                      controller: _addressController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return LeapLocalizations.of(context).shouldNotEmpty;
                        }
                        final address = InternetAddress.tryParse(value!);
                        if (address == null) {
                          return AppLocalizations.of(context).urlNotValid;
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
                          return LeapLocalizations.of(context).shouldNotEmpty;
                        }
                        final number = int.tryParse(value!);
                        if (number == null) {
                          return AppLocalizations.of(context).shouldANumber;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
          actions: [
            ElevatedButton(
              onPressed: kIsWeb
                  ? null
                  : () {
                      if (!(_formKey.currentState?.validate() ?? false)) return;
                      _start();
                    },
              child: Text(AppLocalizations.of(context).start),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
