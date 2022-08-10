import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/header.dart';

class PropertyView extends StatefulWidget {
  const PropertyView({super.key});

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  bool pinned = false;
  double size = 500;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = MediaQuery.of(context).size.width < size;
      return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
          builder: (context, state) {
        final selection = state.selection;
        if (selection == null) {
          return Container();
        }
        return Stack(children: [
          Listener(
            behavior:
                pinned ? HitTestBehavior.translucent : HitTestBehavior.opaque,
            onPointerUp: (details) {
              if (!pinned) _closeView();
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              constraints: BoxConstraints(maxWidth: size, maxHeight: 500),
              child: Material(
                elevation: 6,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(children: [
                  if (!isMobile)
                    MouseRegion(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      child: GestureDetector(
                        child: const Icon(PhosphorIcons.dotsSixVerticalLight),
                        onPanUpdate: (details) {
                          final delta = details.delta.dx;
                          setState(() {
                            size -= delta;
                            size = size.clamp(300, 500);
                          });
                        },
                      ),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Header(
                          title: Text(selection.getLocalizedName(context)),
                          leading: Icon(selection.getIcon(
                              filled: selection.selected.length > 1)),
                          actions: [
                            if (selection.showDeleteButton)
                              IconButton(
                                  icon: const Icon(PhosphorIcons.trashLight),
                                  onPressed: () {
                                    selection.onDelete(context);
                                    context
                                        .read<CurrentIndexCubit>()
                                        .resetSelection();
                                  }),
                            const SizedBox(
                                height: 16, child: VerticalDivider()),
                            if (!isMobile)
                              IconButton(
                                tooltip: pinned
                                    ? AppLocalizations.of(context)!.unpin
                                    : AppLocalizations.of(context)!.pin,
                                icon: pinned
                                    ? const Icon(PhosphorIcons.mapPinFill)
                                    : const Icon(PhosphorIcons.mapPinLight),
                                onPressed: () =>
                                    setState(() => pinned = !pinned),
                              ),
                            IconButton(
                              tooltip: AppLocalizations.of(context)!.close,
                              icon: const Icon(PhosphorIcons.xLight),
                              onPressed: _closeView,
                            ),
                          ],
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: ListView(
                                shrinkWrap: true,
                                children: selection.buildProperties(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]);
      });
    });
  }

  void _closeView() {
    context.read<CurrentIndexCubit>().resetSelection();
  }
}
