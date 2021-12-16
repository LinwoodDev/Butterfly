import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BehaviorsSettingsPage extends StatelessWidget {
  const BehaviorsSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.behaviors),
          actions: [
            if (isWindow()) ...[const VerticalDivider(), const WindowButtons()]
          ],
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.input),
                leading: const Icon(PhosphorIcons.mouseLight),
                subtitle: Text(state.inputType.toLocalizedString(context)),
                onTap: () => _showInput(context),
              ),
            ],
          );
        }));
  }

  void _showInput(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentInput = context.read<SettingsCubit>().state.inputType;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          Future<void> changeInput(InputType inputType) async {
            Navigator.of(ctx).pop();
            cubit.changeInput(inputType);
          }

          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.input,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                ...InputType.values.map((e) {
                  return ListTile(
                      title: Text(e.toLocalizedString(context)),
                      selected: e == currentInput,
                      onTap: () => changeInput(e));
                })
              ]));
        });
  }
}
