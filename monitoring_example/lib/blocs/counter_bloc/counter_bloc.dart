import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monitoring_example/blocs/error_state/error_state.dart';

part 'counter_state.dart';
part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc([int initialValue = 0])
      : assert(initialValue != null),
        super(CounterState(initialValue));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is CounterIncrement) {
      yield CounterState(state.value + event.delta);
    } else if (event is CounterDecrement) {
      yield CounterState(state.value - event.delta);
    } else {
      yield CounterState(state.value, 'Event not valid: $event');
    }
  }

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    super.onTransition(transition);
    print('--------------   From BLOC   ----------------');
    print(transition);
  }
}
