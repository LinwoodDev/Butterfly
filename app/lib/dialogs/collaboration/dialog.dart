import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:butterfly/api/open.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_clipboard/super_clipboard.dart';

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
    final cubit = context.read<CurrentIndexCubit>();
    final service = cubit.state.networkingService;
    return BlocBuilder<NetworkingService, NetworkState?>(
      bloc: service,
      builder: (context, state) {
        final isOpen = state?.connection.isOpen ?? false;
        if (isOpen && state != null) {
          return ViewCollaborationDialog(
            state: state,
            service: service,
            currentIndexCubit: cubit,
          );
        } else {
          return StartCollaborationDialog(service: service);
        }
      },
    );
  }
}
