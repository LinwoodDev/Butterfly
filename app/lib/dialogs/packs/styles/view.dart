import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../bloc/document_bloc.dart';
import 'style.dart';

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
                    .getNamedStyles()
                    .map(
                      (e) => Dismissible(
                        key: ValueKey(e),
                        onDismissed: (direction) {
                          onChanged(value.removeStyle(e.name));
                        },
                        child: ListTile(
                          title: Text(e.name),
                          onTap: () async {
                            final bloc = context.read<DocumentBloc>();
                            var newName = e.name;
                            var styleSheet = e.item;
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => BlocProvider.value(
                                value: bloc,
                                child: StyleDialog(
                                  value: e.item,
                                  onChanged: (value) {
                                    styleSheet = value;
                                  },
                                  name: newName,
                                  onNameChanged: (name) {
                                    newName = name;
                                  },
                                ),
                              ),
                            );
                            if (result != true) return;
                            onChanged(
                              value
                                  .removeStyle(e.name)
                                  .setStyle(newName, styleSheet),
                            );
                          },
                          trailing: IconButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.trash),
                            tooltip: AppLocalizations.of(context).delete,
                            onPressed: () async {
                              onChanged(value.removeStyle(e.name));
                            },
                          ),
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
                final result = await showDialog<String>(
                  context: context,
                  builder: (ctx) => NameDialog(
                    validator: defaultFileNameValidator(
                      context,
                      value.getStyles().toList(),
                    ),
                  ),
                );
                if (result == null) return;
                onChanged(value.setStyle(result, styleSheet));
              },
              icon: const PhosphorIcon(PhosphorIconsLight.plus),
              label: Text(LeapLocalizations.of(context).create),
            ),
          ),
        ],
      ),
    );
  }
}
