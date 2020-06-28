void main() => process(0, 5);

Future<void> process(int index, int max) {
  if (index >= max) {
    return Future.value();
  }
  print('Starting: $index');
  return asyncCall()
      .then((_) => print('Endind: $index'))
      .then((_) => process(index + 1, max));
}

Future<void> asyncCall() {
  const duration = Duration(seconds: 3);
  return Future.delayed(duration);
}
