export 'counter_cubit/counter_cubit.dart';
export 'counter_bloc/counter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:monitoring_example/blocs/error_state/error_state.dart';

export 'error_state/error_state.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (transition.nextState is ErrorStateMixin) {
      if ((transition.nextState as ErrorStateMixin).message != null) {
        print('------ FROM Global -------');
        print(transition);
      }
    }
  }
}
