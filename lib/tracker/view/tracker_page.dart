import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tracker_view.dart';
import '../cubit/list_cubit.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class TrackerPage extends StatelessWidget {
  /// {@macro counter_page}
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrackerCubit(),
      child: TrackerView(),
    );
  }
}
