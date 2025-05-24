import 'package:butterfly/api/open.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';

class KeyboardInputSettings extends StatelessWidget {
  const KeyboardInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).keyboard),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
          child: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) => ListView(
              children: [
                Card(
                  margin: settingsCardMargin,
                  child: Padding(
                    padding: settingsCardPadding,
                    child: ListTile(
                      title: Text(AppLocalizations.of(context).shortcuts),
                      leading: const PhosphorIcon(PhosphorIconsLight.keyboard),
                      onTap: () => openHelp(['shortcuts'], 'keyboard'),
                      trailing: const PhosphorIcon(
                        PhosphorIconsLight.arrowSquareOut,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
