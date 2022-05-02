import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';
import '../../models/painter.dart';
import '../../widgets/header.dart';

typedef PainterChangedCallback<T extends Painter> = void Function(T painter);
typedef PainterWidgetsBuilder<T extends Painter> = List<Widget> Function(
    BuildContext context, T painter, PainterChangedCallback<T> onChanged);

class GeneralPainterDialog<T extends Painter> extends StatefulWidget {
  final IconData icon;
  final String title;
  final String help;
  final int index;
  final PainterWidgetsBuilder<T> builder;
  const GeneralPainterDialog(
      {Key? key,
      required this.icon,
      required this.title,
      required this.help,
      required this.index,
      required this.builder})
      : super(key: key);

  @override
  State<GeneralPainterDialog<T>> createState() =>
      _GeneralPainterDialogState<T>();
}

class _GeneralPainterDialogState<T extends Painter>
    extends State<GeneralPainterDialog<T>> {
  late T painter;

  @override
  void initState() {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    painter = state.document.painters[widget.index] as T;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(child: StatefulBuilder(builder: (context, setState) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(
              title: Text(widget.title),
              leading: Icon(widget.icon),
              help: ['painters', widget.help],
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 200),
                        child: Builder(builder: (context) {
                          return ListView(shrinkWrap: true, children: [
                            TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText:
                                        AppLocalizations.of(context)!.name),
                                initialValue: painter.name,
                                onChanged: (value) => setState(() => painter =
                                    painter.copyWith(name: value) as T)),
                            const SizedBox(height: 8),
                            ...widget.builder(context, painter,
                                (current) => setState(() => painter = current))
                          ]);
                        }),
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.error),
                          child: Text(AppLocalizations.of(context)!.delete),
                          onPressed: () {
                            final bloc = context.read<DocumentBloc>();
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        actions: [
                                          TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .no),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .yes),
                                            onPressed: () {
                                              bloc.add(
                                                  PainterRemoved(widget.index));
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .areYouSure),
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .reallyDelete)));
                          },
                        ),
                        Expanded(child: Container()),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.cancel),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.ok),
                          onPressed: () {
                            context
                                .read<DocumentBloc>()
                                .add(PainterChanged(painter, widget.index));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
