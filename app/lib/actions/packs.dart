import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../dialogs/packs/dialog.dart';

class PacksIntent extends Intent {
  final bool showDocument;

  const PacksIntent({this.showDocument = true});
}

final packsShortcut = ShortcutDefinition(
  id: 'packs',
  intent: const PacksIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyP,
    control: true,
    alt: true,
  ),
);

class PacksAction extends Action<PacksIntent> {
  final BuildContext context;

  PacksAction(this.context);

  @override
  Future<dynamic> invoke(PacksIntent intent) {
    var bloc = context.read<DocumentBloc>();
    var transformCubit = context.read<TransformCubit>();
    return showDialog(
      context: context,
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
