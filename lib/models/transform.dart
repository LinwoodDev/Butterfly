class LayerTranform {
  Vector3? position;
  Vector3? rotation;
  Vector2? size;
  Vector2? minPivot;
  Vector2? maxPivot;

  LayerTranform();
  factory LayerTranform.fromJson(Map<String, dynamic> json) {
    return LayerTranform();
  }
}

enum LayerAlignment { start, center, end }

class Vector2 {
  final int x;
  final int y;

  Vector2(this.x, this.y);
}

class Vector3 extends Vector2 {
  final int z;

  Vector3(int x, int y, this.z) : super(x, y);
}
