import 'package:butterfly/models/elements/type.dart';

abstract class ElementLayerWithChild {
  ElementLayer get child => null;
  set child(ElementLayer value) => {};
}

abstract class ElementLayerWithChildren {
  List<ElementLayer> get child => [];
}
