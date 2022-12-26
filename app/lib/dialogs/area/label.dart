import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';

class AreaLabelDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  AreaLabelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.enterName),
        content: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.name,
            filled: true,
          ),
          controller: _controller,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return AppLocalizations.of(context)!.shouldNotEmpty;
            }
            final state = context.read<DocumentBloc>().state;
            if (state is! DocumentLoadSuccess) {
              return AppLocalizations.of(context)!.error;
            }
            if (state.document.getAreaByName(value!) != null) {
              return AppLocalizations.of(context)!.alreadyExists;
            }
            return null;
          },
        ),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () => Navigator.pop(context, null),
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                Navigator.pop(context, _controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
