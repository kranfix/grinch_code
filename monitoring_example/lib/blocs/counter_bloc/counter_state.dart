part of 'counter_bloc.dart';

class CounterState extends Equatable with ErrorStateMixin {
  const CounterState(this.value, [this.message]) : assert(value != null);

  final int value;
  final String message;

  @override
  List<Object> get props => [value, message];

  @override
  String toString() {
    final reason = message == null ? '' : ', message: $message';
    return 'CounterState($value$reason)';
  }
}
