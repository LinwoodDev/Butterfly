import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/waypoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaypointsIntent extends Intent {
  final BuildContext context;

  const WaypointsIntent(this.context);
}

class WaypointsAction extends Action<WaypointsIntent> {
  WaypointsAction();

  @override
  Future<dynamic> invoke(WaypointsIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    var transformCubit = intent.context.read<TransformCubit>();
    return await showDialog(
      context: intent.context,
      builder: (context) => MultiBlocProvider(providers: [
        BlocProvider.value(value: transformCubit),
        BlocProvider.value(value: bloc),
      ], child: WaypointsDialog()),
    ) as bool?;
  }
}
