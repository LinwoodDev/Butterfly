import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/widgets.dart';

abstract class ElementLayer {
  final String name;
  final String description;

  final List<ElementLayer> children = [];

  ElementLayer({@required this.name, this.description = ''});

  Widget buildTile(BuildContext context, DocumentLoadSuccess state);
}
