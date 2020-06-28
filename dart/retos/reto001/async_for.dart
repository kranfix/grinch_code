void main() {
  asyncFor(0, 5, forBody).then((_) {
    print("-----------------");
    return asyncFor(0, 5, forBody);
  });
}

Future<void> asyncFor(int index, int max, Future<void> Function(int) forBody) {
  if (index >= max) {
    return Future.value();
  }
  return forBody(index).then((_) => asyncFor(index + 1, max, forBody));
}

Future<void> forBody(int index) {
  print('Starting: $index');
  return asyncCall().then((_) => print('Endind: $index'));
}

Future<void> asyncCall() {
  const duration = Duration(seconds: 1);
  return Future.delayed(duration);
}
