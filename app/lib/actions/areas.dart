import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/area/dialog.dart';

class AreasIntent extends Intent {
  final BuildContext context;

  const AreasIntent(this.context);
}

class AreasAction extends Action<AreasIntent> {
  AreasAction();

  @override
  Future<dynamic> invoke(AreasIntent intent) {
    var bloc = intent.context.read<DocumentBloc>();
    var transformCubit = intent.context.read<TransformCubit>();
    return showDialog(
      context: intent.context,
      builder: (context) => MultiBlocProvider(providers: [
        BlocProvider.value(value: transformCubit),
        BlocProvider.value(value: bloc),
      ], child: AreasDialog()),
    );
  }
}
