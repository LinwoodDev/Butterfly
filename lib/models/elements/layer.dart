import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'document.dart';

abstract class ElementLayer {
  List<ElementLayer> children = [];

  ListTile buildTile(BuildContext context, AppDocument document);
}
