part of 'dialog.dart';

class ViewCollaborationDialog extends StatelessWidget {
  final NetworkingService service;
  final NetworkState state;
  final EditorController editorController;

  const ViewCollaborationDialog({
    super.key,
    required this.service,
    required this.state,
    required this.editorController,
  });

  @override
  Widget build(BuildContext context) {
    final info = FutureBuilder<Uri>(
      future: Future.value(state.getShareAddress()),
      builder: (context, snapshot) {
        final address = snapshot.data?.toString() ?? '?';
        final uri = getConnectUri(address);
        final connect = uri.toString();
        final qr = Barcode.qrCode();
        final svg = qr.toSvg(connect, width: 256, height: 256);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 208,
              width: 208,
              child: Stack(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    radius: 12,
                    onTap: () {
                      exportSvg(context, svg, true);
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.string(svg),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton.filledTonal(
                      icon: const Icon(PhosphorIconsLight.copy),
                      onPressed: () async {
                        exportSvg(context, svg, false);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                LeapLocalizations.of(context).copyMessage,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      tooltip: AppLocalizations.of(context).copy,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text(AppLocalizations.of(context).url),
              subtitle: Text(address),
              onTap: () => saveToClipboard(context, connect),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).username,
                filled: true,
              ),
              initialValue: editorController.viewCubit.state.userName,
              onChanged: (value) {
                editorController.viewCubit.setUserName(value);
              },
            ),
          ],
        );
      },
    );
    final userList = StreamBuilder<Set<Channel>>(
      stream: service.connectionsStream,
      builder: (context, snapshot) {
        final connections = snapshot.data ?? {};
        if (connections.isEmpty) {
          return Text(
            AppLocalizations.of(context).noConnections,
            textAlign: TextAlign.center,
          );
        }
        return ListView.builder(
          itemCount: connections.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final channel = connections.elementAt(index);
            final user = service.getUser(channel);
            final hasCustomName = user.name.isNotEmpty;
            final defaultName = AppLocalizations.of(
              context,
            ).defaultUserName(channel);
            Widget title = Text(
              hasCustomName ? user.name : defaultName,
              style: hasCustomName ? null : const TextStyle(color: Colors.grey),
            );
            if (hasCustomName) {
              title = Tooltip(message: defaultName, child: title);
            }
            return ListTile(
              leading: ColorButton.srgb(
                color: getRandomColor(channel),
                size: 24,
              ),
              title: title,
            );
          },
        );
      },
    );
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < LeapBreakpoints.medium;
    return ResponsiveAlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).collaboration),
          Text(
            service.isServer
                ? AppLocalizations.of(context).server
                : AppLocalizations.of(context).client,
            style: TextTheme.of(context).labelLarge,
          ),
        ],
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
      leading: IconButton.outlined(
        icon: const Icon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
      constraints: BoxConstraints(
        maxWidth: LeapBreakpoints.medium,
        maxHeight: 550,
      ),
      content: isMobile
          ? ListView(children: [info, const Divider(), userList])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(child: SingleChildScrollView(child: info)),
                ),
                const VerticalDivider(),
                Expanded(child: SingleChildScrollView(child: userList)),
              ],
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
