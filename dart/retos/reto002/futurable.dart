import 'dart:async';

class Futurable<T extends num> implements Future<T> {
  Futurable([this.computation]);

  Future<T> _future;
  final FutureOr<T> Function() computation;

  Future<T> _init() {
    if (_future == null) {
      _future = Future(computation);
    }
    return _future;
  }

  @override
  Stream<T> asStream() => _future.asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error) test}) {
    return _init().catchError(onError, test: test);
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue, {Function onError}) {
    return _init().then(onValue, onError: onError);
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function() onTimeout}) =>
      _init().timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr Function() action) =>
      _init().whenComplete(action);
}

class Duplicatable<N extends num> extends Futurable<N> {
  Duplicatable(N value)
      : _value = value,
        super(() => Future.delayed(Duration(seconds: 1), () => value));

  final N _value;

  Duplicatable<N> duplicate() => Duplicatable(2 * _value);
}

Duplicatable<T> createDelayedFuture<T extends num>(T value) =>
    Duplicatable<T>(value);

void main() async {
  final _future = createDelayedFuture<int>(4);

  // espera un segundo
  final value = await _future;
  print(value); // imprime 4

  // espera un segundos
  final _duplicatedFuture = _future.duplicate();
  final duplicated = await _duplicatedFuture;
  print(duplicated); // imprime 8
}
