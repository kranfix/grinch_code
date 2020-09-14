def solution(A):
    indicator = Indicator()
    output = indicator.split(A, 100000)
    print(output.val)
    return output.val

def half(n) :
  return (n - (n % 2)) / 2

class Array:
  def __init__(self, low, big):
    self._array = []
    self.low = low
    self.big = big

  def __len__(self):
    return len(self._array)
  
  def add(self, val):
    self._array.append(val)
    if (val > self.big) :
      self.big = val
    if (val < self.low) :
      self.low = val
  
  def __iter__(self):
    return iter(self._array)

class Indicator:
  val = 1
  next = 2

  def update(self, val):
    if (val < self.val):
      return False
    if (self.next == val) :
      self.next += 1
      return False
    if (self.val == val) :
      self.val = self.next
      self.next += 1
      return False
    return True

  def split(self, array, max) :
    n = len(array)
    if (n == 0) :
      return self
    pivot = half(self.val + max)
  
    left = Array(pivot - 1, self.val)
    right = Array(max, pivot)
    
    for item in array :
      if(self.update(item)):
        (left if item < pivot else right).add(item)

    if (self.val > right.big or self.val < left.low) :
      return self
    elif (self.val >= right.low) :
      return self.split(right, right.big)
    elif (self.val > left.big) :
      return self
    else:
      self.split(left, left.big)
      if (self.val < right.low or len(right) == 0) :
        return self
      return self.split(right, right.big)


solution([1, 3, 6, 1, 2])
solution([-1, -3])
solution([60000, 50000, 9, 5, 6, 8, 4, 1000, 3, 2, 1])
solution([9, 5, 6, 8, 4, 3, 2, 1])
solution([20, 2, 17, 4, 15, 6, 13, 8, 11, 10, 9, 12, 7, 14, 5, 16, 3, 19, 1])
