use std::f64::consts::PI;

fn main() {
  let rect = Rect { width: 4.0, height: 5.0 };
  let circle = Circle { radius: 3.0 };

  Shape::format(&rect);
  Shape::format(&circle);
}

trait Shape: ToString {
  fn area(&self) -> f64;
  fn perimeter(&self) -> f64;

  fn format(shape: &Self) {
    println!("{}", shape.to_string());
    println!("  area: {}", shape.area());
    println!("  perimeter: {}", shape.perimeter());
  }
}

struct Rect {
  width: f64,
  height: f64,
}

struct Circle {
  radius: f64,
}

impl Shape for Rect {
  fn area(&self) -> f64 {
    self.width * self.height
  }

  fn perimeter(&self) -> f64 {
    2.0 * (self.width + self.height)
  }
}

impl ToString for Rect {
  fn to_string(&self) -> String {
    format!("Rect(width: {}, height: {})", self.width, self.height)
  }
}

impl Shape for Circle {
  fn area(&self) -> f64 {
    PI * self.radius * self.radius
  }

  fn perimeter(&self) -> f64 {
    2.0  * PI * self.radius
  }
}

impl ToString for Circle {
  fn to_string(&self) -> String {
    format!("Circle(radius: {})", self.radius)
  }
}