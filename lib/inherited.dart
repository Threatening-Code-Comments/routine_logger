import 'package:flutter/cupertino.dart';
import 'package:routine_logger/routine.dart';

class CurrentRoutine extends InheritedWidget {
  const CurrentRoutine({
    super.key,
    required this.routine,
    required super.child,
  });

  final Routine routine;

  static CurrentRoutine of(BuildContext context) {
    final CurrentRoutine? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in Context');
    return result!;
  }

  static CurrentRoutine? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CurrentRoutine>();
  }

  @override
  bool updateShouldNotify(covariant CurrentRoutine oldWidget) =>
      routine != oldWidget.routine;
}
