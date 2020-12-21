import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/widgets.dart';

abstract class ElementLayer {
  final List<ElementLayer> children = [];

  Widget buildTile(BuildContext context, DocumentLoadSuccess state);
}
