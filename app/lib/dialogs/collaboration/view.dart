import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/collaboration/start.dart';
import 'package:butterfly/services/network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ViewCollaborationDialog extends StatelessWidget {
  const ViewCollaborationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const side = NetworkSide.client;
    const type = kIsWeb ? NetworkType.webRtc : NetworkType.webSocket;
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context).collaboration),
          IconButton.outlined(
            icon: const PhosphorIcon(PhosphorIconsLight.stop),
            onPressed: () {
              final bloc = context.read<DocumentBloc>();
              final state = bloc.state;
              if (state is! DocumentLoaded) return;
              state.networkService.close();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(switch (side) {
                  NetworkSide.client => AppLocalizations.of(context).client,
                  NetworkSide.server => AppLocalizations.of(context).server,
                }),
                const SizedBox(width: 8),
                const PhosphorIcon(PhosphorIconsLight.circle, size: 8),
                const SizedBox(width: 8),
                Text(switch (type) {
                  NetworkType.webRtc => AppLocalizations.of(context).webRtc,
                  NetworkType.webSocket =>
                    AppLocalizations.of(context).webSocket,
                }),
              ],
            ),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1,
              child: Material(
                elevation: 8,
                child: Column(
                  children: [
                    const Expanded(child: Placeholder()),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.share),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue:
                  'https://butterfly.linwood.dev/collab/websocket?url=127.0.0.1&port=3000',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).url,
                filled: true,
                suffixIcon: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.share),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

Future<void> showCollaborationDialog(BuildContext context) async {
  final bloc = context.read<DocumentBloc>();
  final state = bloc.state;
  if (state is! DocumentLoaded) return;
  final network = state.networkService;
  final dialog = network.isActive
      ? const ViewCollaborationDialog()
      : const StartCollaborationDialog();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: bloc,
      child: dialog,
    ),
  );
}
