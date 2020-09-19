import 'dart:math' show pi;

void main() {
  const rect = Rect(4, 5);
  const circle = Circle(3);

  Shape.format(rect);
  Shape.format(circle);

  final map1 = <String, dynamic>{
    'runtimeType': 'Circle',
    'radius': 3.0,
  };
  final map2 = <String, dynamic>{
    'runtimeType': 'Rect',
    'width': 4.0,
    'height': 5.0,
  };

  final circle1 = Shape.fromMap(map1) as Circle;
  final rect1 = Shape.fromMap(map2);
  Shape.format(rect1);
  Shape.format(circle1);
}

abstract class Shape {
  double get area;
  double get perimeter;

  static Shape fromMap(Map<String, dynamic> map) {
    if (map['runtimeType'] == "Circle") {
      return Circle(map['radius']);
    } else if (map['runtimeType'] == 'Rect') {
      return Rect(map['width'], map['height']);
    }
    return null;
  }

  static void format(Shape shape) {
    print('$shape: ${shape.runtimeType}');
    print('  area: ${shape.area}');
    print('  perimeter: ${shape.perimeter}');
  }
}

class Rect implements Shape {
  const Rect(this.width, this.height)
      : assert(width != null),
        assert(height != null);

  final double width;
  final double height;

  @override
  double get area => width * height;

  @override
  double get perimeter => 2 * (width + height);

  @override
  String toString() {
    return "Rect($width, $height)";
  }
}

class Circle implements Shape {
  const Circle(this.radius) : assert(radius != null);

  final double radius;

  @override
  double get area => pi * radius * radius;

  @override
  double get perimeter => 2 * pi * radius;

  @override
  String toString() {
    return "Circle($radius)";
  }
}
