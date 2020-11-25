import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'document.dart';

abstract class LayerElement {
  ListTile buildTile(BuildContext context, AppDocument document);
}
