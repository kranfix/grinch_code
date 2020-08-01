void main() {
  final list = InmutableList<int>([2, 4, 1]);
  print(list[1]);
}

class InmutableList<T> {
  final List<T> _list;

  const InmutableList(this._list);

  T operator [](int index) {
    return _list[index];
  }

  //void operator []=(T value, int index) {
  //  _list[index] = value;
  //}
}
