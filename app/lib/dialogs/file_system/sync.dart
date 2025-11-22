import 'package:butterfly/visualizer/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
          icon: PhosphorIcon(
            status.getIcon(),
            textDirection: TextDirection.ltr,
            color: status?.getColor(ColorScheme.of(context)),
          ),
          tooltip: status.getLocalizedName(context),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => const SyncDialog(),
          ),
        );
      },
    );
  }
}
