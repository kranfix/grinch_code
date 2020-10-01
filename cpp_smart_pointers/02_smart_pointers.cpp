#include <iostream>
#include <memory>
#include <string>

#define LOG(x) std::cout << x << std::endl

template <class R>
struct StrongShared;

template <class R>
struct WeakShared;

struct StrongA;
struct StrongB;
struct StrongX;
struct WeakY;

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

template <class R>
struct StrongShared
{
  std::shared_ptr<R> ref;
  std::string tag;

  StrongShared(std::string tag) : tag(tag)
  {
    LOG("StrongShared(\"" << tag << "\")");
  }

  ~StrongShared()
  {
    LOG("~StrongShared(\"" << tag << "\")");
  }
};

template <class R>
struct WeakShared
{
  std::weak_ptr<R> ref;
  std::string tag;

  WeakShared(std::string tag) : tag(tag)
  {
    LOG("WeakShared(\"" << tag << "\")");
  }

  ~WeakShared()
  {
    LOG("~WeakShared(\"" << tag << "\")");
  }
};

struct StrongA : StrongShared<StrongB>
{
  StrongA(std::string tag) : StrongShared<StrongB>(tag) {}
};

struct StrongB : StrongShared<StrongA>
{
  StrongB(std::string tag) : StrongShared<StrongA>(tag) {}
};

struct StrongX : StrongShared<WeakY>
{
  StrongX(std::string tag) : StrongShared<WeakY>(tag) {}
};

struct WeakY : WeakShared<StrongX>
{
  WeakY(std::string tag) : WeakShared<StrongX>(tag) {}
};

int main()
{
  LOG("\nUNIQUE_PTR:");
  {
    std::unique_ptr<Circle> pCircle = std::make_unique<Circle>(1.0);

    // This does not work
    //std::unique_ptr<Circle> pCircle1 = pCircle;
  }

  LOG("\nUNIQUE_PTR with mupltiple scopes:");
  {
    std::unique_ptr<Circle> pCircle;
    {
      pCircle = std::make_unique<Circle>(2.0);
    }
    pCircle->log();
  }

  LOG("\nSHARED_PTR:");
  {
    std::shared_ptr<Circle> pCircle;
    {
      std::shared_ptr<Circle> pCircle1 = std::make_shared<Circle>(3.0);
      pCircle = pCircle1;
    }
    pCircle->log();
  }

  LOG("\nSHARED_PTR failing to free memory:");
  {
    auto a = std::make_shared<StrongA>("A");
    auto b = std::make_shared<StrongB>("B");
    a->ref = b;
    b->ref = a;
  }

  LOG("\nSHARED_PTR using WEAK_PTR to free memory:");
  {
    auto x = std::make_shared<StrongX>("X");
    auto y = std::make_shared<WeakY>("Y");
    x->ref = y;
    y->ref = x;
  }

  return 0;
}