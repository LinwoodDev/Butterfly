part of 'dialog.dart';

class ViewCollaborationDialog extends StatelessWidget {
  final NetworkingService service;
  final NetworkingState state;

  const ViewCollaborationDialog({
    super.key,
    required this.service,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      scrollable: true,
      actions: [
        OutlinedButton(
          child: Text(AppLocalizations.of(context).stop),
          onPressed: () {
            Navigator.of(context).pop();
            service.closeNetworking();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
