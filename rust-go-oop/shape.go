package main

import (
	"fmt"
	"math"
)

func main() {
	rect := Rect{width: 4.0, height: 5.0}
	circle := Circle{radius: 3.0}
	shapeFormat(rect)
	shapeFormat(circle)
}

type Shape interface {
	area() float64
	perimeter() float64
}

type Rect struct {
	width, height float64
}

type Circle struct {
	radius float64
}

func (r Rect) area() float64 {
	return r.width * r.height
}

func (r Rect) perimeter() float64 {
	return 2 * (r.width + r.height)
}

func (r Rect) String() string {
	return fmt.Sprintf("Rect(%f, %f)", r.width, r.height)
}

func (c Circle) area() float64 {
	return math.Pi * c.radius * c.radius
}

func (c Circle) perimeter() float64 {
	return 2 * math.Pi * c.radius
}

func (c Circle) String() string {
	return fmt.Sprintf("Circle(%f)", c.radius)
}

func shapeFormat(shape Shape) {
	fmt.Printf("%v: %T \n", shape, shape)
	fmt.Printf("  area: %f\n", shape.area())
	fmt.Printf("  perimeter: %f\n", shape.perimeter())
}
