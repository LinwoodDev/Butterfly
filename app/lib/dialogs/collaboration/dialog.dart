import 'dart:io';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';

part 'start.dart';
part 'view.dart';

Future<void> showCollaborationDialog(BuildContext context) {
  final bloc = context.read<DocumentBloc>();
  final currentIndexCubit = context.read<CurrentIndexCubit>();

  return showDialog(
    context: context,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: bloc),
        BlocProvider.value(value: currentIndexCubit),
      ],
      child: const CollaborationDialog(),
    ),
  );
}

class CollaborationDialog extends StatelessWidget {
  const CollaborationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.read<CurrentIndexCubit>().state.networkingService;
    return StreamBuilder<NetworkState?>(
      stream: service.stream,
      builder: (context, snapshot) {
        final isActive = snapshot.data != null;
        if (isActive) {
          return ViewCollaborationDialog(
            state: snapshot.data!,
            service: service,
          );
        } else {
          return StartCollaborationDialog(service: service);
        }
      },
    );
  }
}
