void main() {
  print('Paso 1');

  Future.delayed(Duration(seconds: 3), () {
    print('Delayed');
  });

  final future = generateFuture();

  print('Paso 2');
  print('Paso 3');
  print('Paso 4');

  future.whenComplete(() {
    print('Futuro terminado');
  });
}

Future<void> generateFuture() async {
  final counter = await 10;

  print('Futuro 2');
  final value = await (counter * 2.0);

  print('Futuro 3');
  print(value);
  //return Future.value(10).then((counter) {
  //  print('Futuro 2');
  //  return counter * 2.0;
  //}).then<void>((value) {
  //  print('Futuro 3');
  //  print(value);
  //});
}
