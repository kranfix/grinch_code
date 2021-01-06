part of 'counter_bloc.dart';

abstract class CounterEvent {}

class CounterIncrement implements CounterEvent {
  const CounterIncrement([this.delta = 1]) : assert(delta != null && delta > 0);

  final int delta;

  @override
  String toString() {
    return 'CounterIncrement($delta)';
  }
}

class CounterDecrement implements CounterEvent {
  const CounterDecrement([this.delta = 1]) : assert(delta != null && delta > 0);

  final int delta;

  @override
  String toString() {
    return 'CounterIncrement($delta)';
  }
}
