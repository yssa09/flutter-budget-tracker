import 'package:flutter/material.dart';
import 'tracker/view/tracker_page.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [CounterPage].
/// {@endtemplate}
class TrackerApp extends MaterialApp {
  /// {@macro counter_app}
  const TrackerApp({super.key}) : super(home: const TrackerPage());
}
