void main() {
  final date1 = DateTime.now();
  print(date1);

  final date2 = DateTime.parse('2020-04-20 15:34:30.0');
  print(date2);

  print(date1.difference(date2));

  final tictoc = TicToc();

  while (true) {
    final current = DateTime.now();
    final duration = current.difference(date1);
    if (duration.inSeconds >= 3) {
      break;
    }
  }

  tictoc.toc();
}

class TicToc {
  TicToc() : _initial = DateTime.now();

  DateTime _initial;

  void tic() {
    _initial = DateTime.now();
  }

  void toc() {
    final current = DateTime.now();
    final duration = current.difference(_initial);

    print('${duration.inMilliseconds / 1000.0}');
  }
}
