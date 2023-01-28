import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tracker/app.dart';
import 'package:flutter_tracker/tracker_observer.dart';

void main() {
  Bloc.observer = TrackerObserver();
  runApp(const TrackerApp());
}
