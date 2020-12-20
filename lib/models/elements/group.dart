import 'package:butterfly/models/elements/layer.dart';
import 'package:flutter/material.dart';

import '../document.dart';

class GroupElement extends ElementLayer {
  @override
  Widget buildTile(BuildContext context, AppDocument document) => ListTile();
}
