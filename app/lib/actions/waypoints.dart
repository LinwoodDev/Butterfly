import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/waypoints.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaypointsIntent extends Intent {
  final BuildContext context;

  const WaypointsIntent(this.context);
}

class WaypointsAction extends Action<WaypointsIntent> {
  final DocumentBloc bloc;

  WaypointsAction(this.bloc);

  @override
  Object? invoke(WaypointsIntent intent) {
    var transformCubit = intent.context.read<TransformCubit>();
    showDialog(
      context: intent.context,
      builder: (context) => WaypointsDialog(
        bloc: bloc,
        cameraCubit: transformCubit,
      ),
    );
  }
}
