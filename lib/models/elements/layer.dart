import 'package:flutter/widgets.dart';

import 'document.dart';

abstract class ElementLayer {
  List<ElementLayer> children = [];

  Widget buildTile(BuildContext context, AppDocument document);
}
