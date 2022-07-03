import 'package:butterfly/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/sync.dart';
import '../sync.dart';

class SyncButton extends StatelessWidget {
  final String remote;
  const SyncButton({super.key, required this.remote});

  @override
  Widget build(BuildContext context) {
    final sync = context.read<SyncService>().getSync(remote);
    return StreamBuilder<SyncStatus>(
      stream: sync?.statusStream,
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null) {
          return Container();
        }
        return IconButton(
          icon: Icon(status.getIcon()),
          tooltip: status.getLocalizedName(context),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => SyncDialog(
              remote: remote,
            ),
          ),
        );
      },
    );
  }
}
