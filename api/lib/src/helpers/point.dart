import 'dart:math';

extension PointHelper on Point<double> {
  Point<double> operator -() => Point(-x, -y);
}
