part of 'dialog.dart';

class ViewCollaborationDialog extends StatelessWidget {
  final NetworkingService service;
  final NetworkState state;

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
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            FutureBuilder<String>(
              future: Future.value(state.getShareAddress()),
              builder: (context, snapshot) {
                final address = snapshot.data ?? '?';
                final connect = getConnectUri(address).toString();
                final qr = Barcode.qrCode();
                final svg = qr.toSvg(connect, width: 256, height: 256);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 208,
                        width: 208,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            radius: 12,
                            onTap: () {
                              exportSvg(context, svg, true);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    ColoredBox(color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.string(svg),
                                    ),
                                  ]),
                            ))),
                    const SizedBox(height: 8),
                    ListTile(
                      title: Text(AppLocalizations.of(context).url),
                      subtitle: Text(address),
                      onTap: () => saveToClipboard(context, connect),
                    ),
                  ],
                );
              },
            ),
            const Divider(),
            StreamBuilder<Set<Channel>>(
                stream: service.connectionsStream,
                builder: (context, snapshot) {
                  final connections = snapshot.data ?? {};
                  if (connections.isEmpty) {
                    return Text(AppLocalizations.of(context).noConnections);
                  }
                  return Column(
                    children: [
                      for (final connection in connections)
                        ListTile(
                          leading: ColorButton.srgb(
                            color: getRandomColor(connection),
                            size: 24,
                          ),
                          title: Text(connection.toString()),
                        ),
                    ],
                  );
                }),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          child: Text(AppLocalizations.of(context).stop),
          onPressed: () {
            service.closeNetworking();
          },
        ),
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
