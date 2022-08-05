import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/document_bloc.dart';
import '../../models/element.dart';
import '../../renderers/renderer.dart';
import '../../visualizer/element.dart';
import '../../widgets/context_menu.dart';
import 'general.dart';
import 'image.dart';
import 'label.dart';
import 'pen.dart';
import 'shape.dart';
import 'svg.dart';

class ElementsDialog extends StatefulWidget {
  final List<Renderer<PadElement>> elements;
  final ContextCloseFunction close;
  final Offset position;
  final ValueChanged<Renderer<PadElement>>? onChanged;
  const ElementsDialog(
      {super.key,
      required this.elements,
      required this.close,
      this.onChanged,
      required this.position});

  @override
  State<ElementsDialog> createState() => _ElementsDialogState();
}

class _ElementsDialogState extends State<ElementsDialog> {
  int _selectedElement = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    PadElement? element;
    if (_selectedElement < widget.elements.length && _selectedElement >= 0) {
      element = widget.elements[_selectedElement].element;
    }
    Widget content =
        Center(child: Text(AppLocalizations.of(context)!.selectElement));
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return content;
    final index =
        element == null ? -1 : state.document.content.indexOf(element);
    if (index >= 0 && index < state.document.content.length) {
      if (element is LabelElement) {
        content = LabelElementDialog(
            index: index, close: widget.close, position: widget.position);
      } else if (element is ImageElement) {
        content = ImageElementDialog(
            index: index, close: widget.close, position: widget.position);
      } else if (element is SvgElement) {
        content = SvgElementDialog(
            index: index, close: widget.close, position: widget.position);
      } else if (element is PenElement) {
        content = PenElementDialog(
            index: index, close: widget.close, position: widget.position);
      } else if (element is ShapeElement) {
        content = ShapeElementDialog(
            index: index, close: widget.close, position: widget.position);
      } else if (element != null) {
        content = GeneralElementDialog(
            position: widget.position, index: index, close: widget.close);
      }
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (widget.elements.length > 1) ...[
        SizedBox(
          width: 50,
          child: ListView.builder(
            itemCount: widget.elements.length,
            controller: _scrollController,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                widget.onChanged?.call(widget.elements[index]);
                setState(() => _selectedElement = index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  widget.elements[index].element.getIcon(),
                  size: 36,
                  color: _selectedElement == index
                      ? Theme.of(context).primaryColor
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
      const SizedBox(width: 10),
      Expanded(child: content)
    ]);
  }
}
