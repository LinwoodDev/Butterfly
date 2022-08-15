import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/services/import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/insert.dart';

class InsertIntent extends Intent {
  final BuildContext context;
  final Offset position;

  const InsertIntent(this.context, this.position);
}

class InsertAction extends Action<InsertIntent> {
  InsertAction();

  @override
  Future<dynamic> invoke(InsertIntent intent) {
    return showDialog(
      context: intent.context,
      builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: intent.context.read<DocumentBloc>()),
            BlocProvider.value(value: intent.context.read<TransformCubit>()),
            BlocProvider.value(value: intent.context.read<CurrentIndexCubit>())
          ],
          child: RepositoryProvider.value(
              value: intent.context.read<ImportService>(),
              child: InsertDialog(position: intent.position))),
    );
  }
}
