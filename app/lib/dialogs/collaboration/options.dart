import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/widgets/movable_dialog.dart';

typedef CollaborationOptionsResult = ({
  CollaborationSettings settings,
  bool persistent,
});

Future<void> showCollaborationOptionsDialog(
  BuildContext context, {
  CollaborationSettings? initialSettings,
  void Function(CollaborationSettings?)? onSessionSettingsChanged,
}) async {
  final cubit = context.read<SettingsCubit>();
  final result = await showMovableDialog<CollaborationOptionsResult>(
    context: context,
    builder: (context) => CollaborationOptionsDialog(
      initialSettings: initialSettings ?? cubit.state.collaboration,
      showSessionAction: onSessionSettingsChanged != null,
    ),
  );
  if (result == null || cubit.isClosed) return;
  if (result.persistent) {
    await cubit.changeCollaborationSettings(result.settings);
    onSessionSettingsChanged?.call(null);
  } else {
    onSessionSettingsChanged?.call(result.settings);
  }
}

class CollaborationOptionsDialog extends StatefulWidget {
  final CollaborationSettings? initialSettings;
  final bool showSessionAction;

  const new({super.key, this.initialSettings, this.showSessionAction = false});

  @override
  State<CollaborationOptionsDialog> createState() =>
      _CollaborationOptionsDialogState();
}

class _CollaborationOptionsDialogState
    extends State<CollaborationOptionsDialog> {
  late CollaborationSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.initialSettings ?? const CollaborationSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).collaborationOptions),
      breakpoint: LeapBreakpoints.medium,
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
      content: ListView(
        shrinkWrap: true,
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context).syncToolbar),
            subtitle: Text(AppLocalizations.of(context).syncToolbarDescription),
            value: _settings.syncToolbar,
            onChanged: (value) {
              setState(() {
                _settings = _settings.copyWith(syncToolbar: value);
              });
            },
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).syncCurrentPage),
            subtitle: Text(
              AppLocalizations.of(context).syncCurrentPageDescription,
            ),
            value: _settings.syncCurrentPage,
            onChanged: (value) {
              setState(() {
                _settings = _settings.copyWith(syncCurrentPage: value);
              });
            },
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).syncCurrentArea),
            subtitle: Text(
              AppLocalizations.of(context).syncCurrentAreaDescription,
            ),
            value: _settings.syncCurrentArea,
            onChanged: _settings.syncCurrentPage
                ? (value) {
                    setState(() {
                      _settings = _settings.copyWith(syncCurrentArea: value);
                    });
                  }
                : null,
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).showCursor),
            subtitle: Text(AppLocalizations.of(context).showCursorDescription),
            value: _settings.showCursor,
            onChanged: (value) {
              setState(() {
                _settings = _settings.copyWith(showCursor: value);
              });
            },
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context).showTemporary),
            subtitle: Text(
              AppLocalizations.of(context).showTemporaryDescription,
            ),
            value: _settings.showTemporary,
            onChanged: (value) {
              setState(() {
                _settings = _settings.copyWith(showTemporary: value);
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        if (widget.showSessionAction)
          OutlinedButton(
            onPressed: () =>
                Navigator.of(context)
                    .pop((settings: _settings, persistent: false)),
            child: Text(AppLocalizations.of(context).saveForCurrentSession),
          ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop((settings: _settings, persistent: true));
          },
          child: Text(AppLocalizations.of(context).saveAsDefault),
        ),
      ],
    );
  }
}
