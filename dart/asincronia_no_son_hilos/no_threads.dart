TicToc tictoc;

void main() {
  tictoc = TicToc();

  asyncDelay(4, "A");
  asyncDelay(5, "B");

  // Select only one to observe the effect
  // Seleccione solo uno para observar los efectos
  syncDelay(3, "C");
  //syncDelay(6, "C");
}

Future<void> asyncDelay(int seconds, String tag) async {
  final _tictoc = TicToc();
  print('[$tag] ${_tictoc.toc()} -- ${tictoc.toc()}');
  final duration = Duration(seconds: seconds);
  await Future.delayed(duration);
  print('[$tag] ${_tictoc.toc()} -- ${tictoc.toc()}');
}

void syncDelay(int seconds, String tag) {
  final _tictoc = TicToc();
  print('[$tag] ${_tictoc.toc()} -- ${tictoc.toc()}');
  while (_tictoc.elapse.inSeconds < seconds);
  print('[$tag] ${_tictoc.toc()} -- ${tictoc.toc()}');
}

class TicToc {
  TicToc() : _start = DateTime.now();

  DateTime _start;

  String toc() {
    return '${elapse.inMilliseconds / 1000.0}';
  }

  Duration get elapse {
    final now = DateTime.now();
    return now.difference(_start);
  }
}
