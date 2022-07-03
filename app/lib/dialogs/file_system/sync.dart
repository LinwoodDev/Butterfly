import 'package:butterfly/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/sync.dart';
import '../sync.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.read<SyncService>();
    return StreamBuilder<SyncStatus>(
      stream: service.statusStream,
      builder: (context, snapshot) {
        final status = snapshot.data;
        return IconButton(
          icon: Icon(status.getIcon()),
          tooltip: status.getLocalizedName(context),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const SyncDialog(),
          ),
        );
      },
    );
  }
}
