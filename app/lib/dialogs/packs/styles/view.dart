import 'package:butterfly/dialogs/packs/styles/style.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../bloc/document_bloc.dart';

class StylesPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const StylesPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: value
                    .getStyles()
                    .map(
                      (e) => Dismissible(
                        key: ValueKey(e),
                        onDismissed: (direction) {
                          // TODO: Remove style
                        },
                        child: ListTile(
                          title: Text(e),
                          onTap: () async {
                            var styleSheet = value.getStyle(e);
                            final bloc = context.read<DocumentBloc>();
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => BlocProvider.value(
                                value: bloc,
                                child: StyleDialog(
                                  value: styleSheet!,
                                  onChanged: (value) {
                                    styleSheet = value;
                                  },
                                ),
                              ),
                            );
                            if (result != true) return;
                            value.setStyle(styleSheet!);
                            onChanged(value);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              onPressed: () async {
                var styleSheet = const text.TextStyleSheet();
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => StyleDialog(
                    value: styleSheet,
                    onChanged: (value) {
                      styleSheet = value;
                    },
                  ),
                );
                if (result != true) return;
                value.setStyle(styleSheet);
                onChanged(value);
              },
              icon: const PhosphorIcon(PhosphorIconsLight.plus),
              label: Text(AppLocalizations.of(context).create),
            ),
          ),
        ],
      ),
    );
  }
}
