#include <iostream>

#define LOG(x) std::cout << x << std::endl

class Circle
{
public:
  double radius;

  Circle(double radius) : radius(radius)
  {
    LOG("Circle(" << radius << ")");
  }

  ~Circle()
  {
    LOG("~Circle(" << radius << ")");
  }

  void log()
  {
    LOG("  radius: " << radius);
  }
};

template <class T>
struct OwnerPtr
{
public:
  T *ref;
  OwnerPtr(T *ptr)
  {
    ref = ptr;
  }

  ~OwnerPtr()
  {
    if (ref != nullptr)
    {
      delete ref;
    }
  }

  T *operator->()
  {
    return this->ref;
  }

  T &operator*()
  {
    return *(this->ref);
  }
};

int main()
{
  LOG("\nUSING STACK");
  {
    Circle c1 = Circle(1.0);
    auto c2 = Circle(2.0);
    c1.log();
    c2.log();
  }

  LOG("\nUSING HEAP WITHOUT CLEANING MEMORY");
  {
    Circle *c1 = new Circle(3.0);
    auto c2 = new Circle(4.0);
    c1->log();
    c2->log();
  }

  LOG("\nUSING HEAP CLEANING MEMORY");
  {
    Circle *pC1 = new Circle(5.0);
    auto pC2 = new Circle(6.0);
    pC1->log();
    pC2->log();
    delete pC2;
    delete pC1;
  }

  LOG("\nOWNER POINTER");
  {
    OwnerPtr<Circle> pC1 = OwnerPtr<Circle>(new Circle(7.0));
    Circle *_pC2 = new Circle(8.0);
    auto pC2 = OwnerPtr<Circle>(_pC2);
    pC1->log();
    (*pC2).log();
  }

  LOG("\nMAIN: return");
  return 0;
}