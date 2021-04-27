import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/widgets.dart';

abstract class InspectorItem {
  Widget buildInspector(DocumentBloc bloc);
}
