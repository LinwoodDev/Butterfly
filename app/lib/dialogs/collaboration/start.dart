part of 'dialog.dart';

class StartCollaborationDialog extends StatelessWidget {
  final NetworkingService service;

  const StartCollaborationDialog({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      content: SizedBox(
        width: 300,
        height: 150,
        child: Column(children: [
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
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
        ElevatedButton(
          onPressed: () {
            final bloc = context.read<DocumentBloc>();
            final state = bloc.state;
            if (state is! DocumentLoaded) return;
            Navigator.of(context).pop();
            state.networkingService.createSocketServer();
          },
          child: Text(AppLocalizations.of(context).start),
        ),
      ],
    );
  }
}
