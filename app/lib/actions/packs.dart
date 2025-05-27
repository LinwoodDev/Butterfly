import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/packs/dialog.dart';

class PacksIntent extends Intent {
  final bool showDocument;
  final BuildContext context;

  const PacksIntent(this.context, [this.showDocument = true]);
}

class PacksAction extends Action<PacksIntent> {
  PacksAction();

  @override
  Future<dynamic> invoke(PacksIntent intent) {
    var bloc = intent.context.read<DocumentBloc>();
    var transformCubit = intent.context.read<TransformCubit>();
    return showDialog(
      context: intent.context,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: transformCubit),
          BlocProvider.value(value: bloc),
        ],
        child: PacksDialog(globalOnly: !intent.showDocument),
      ),
    );
  }
}
