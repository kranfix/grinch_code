void main() async {
  await myFor();
  print('---------------');
  await myFor();
}

Future<void> myFor() async {
  for (var i = 0; i < 5; i++) {
    print('Starting: $i');
    await asyncCall();
    print('Endind: $i');
  }
}

Future<void> asyncCall() {
  const duration = Duration(seconds: 1);
  return Future.delayed(duration);
}
