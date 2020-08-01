void main() {
  var a = MyList(['hola', 'Hello', 'Hallo']);
  final b = MyList(['Hi', 'Ciao']);
  const c = MyList(['Grinch', 'Code']);

  print('a: $a');
  //print('b: $b');
  //print('c: $c');

  a = MyList([]);
  //b = MyList([]); // Not allowed
  //a.list[0] = 'Hola';
  //b.list[0] = 'Hola';
  //c.list[0] = 'Hola';

  print('a: $a');
  //print('b: $b');
  //print('c: $c');
}

class MyList {
  final List<String> list;

  const MyList(this.list);

  @override
  String toString() => 'MyList($list)';
}
