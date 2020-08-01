class MyInt {
  final int value;

  const MyInt(this.value);

  @override
  bool operator ==(Object other) {
    //return hashCode == other.hashCode;
    if (other is MyInt) {
      return value == other.value;
    } else if (other is int) {
      return value == other;
    }
    return false;
  }

  @override
  int get hashCode => value;

  @override
  String toString() {
    return 'MyInt($value)';
  }
}

void main() {
  const a = MyInt(4);
  var b = MyInt(4);
  const c = MyInt(5);

  b = MyInt(5);

  print('a == b: ${a == b}');
  print('a == 4: ${a == 4}');
  print('4 == a: ${4 == a}');
  print('a: $a ${a.hashCode} ${a.runtimeType}');
  print('b: $b ${b.hashCode} ${b.runtimeType}');
}
