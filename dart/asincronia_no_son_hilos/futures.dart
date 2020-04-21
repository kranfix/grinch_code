import 'dart:async';

void main() {
  print('Paso 1');

  final delayed = Future.delayed(Duration(seconds: 3));
  delayed.then((_) {
    print('Delayed');
  });

  final Future<int> future = Future.value(10);

  print('Paso 2');

  final future2 = future.then((counter) {
    print('Futuro 2');
    return counter * 2.0;
  });

  print('Paso 3');

  future2.then((value) {
    print('Futuro 3');
    print(value);
  });

  print('Paso 4');
}
