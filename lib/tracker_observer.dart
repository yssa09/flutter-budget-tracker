import 'package:bloc/bloc.dart';

// / {@template counter_observer}
// / [BlocObserver] for the counter application which
// / observes all state changes.
// / {@endtemplate}
class TrackerObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}
