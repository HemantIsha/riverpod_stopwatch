import 'dart:async';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_stopwatch/models/timer.dart';

final timerProvider = StateNotifierProvider<TimersProvider, TimerModel>(
  (ref) => TimersProvider(),
);

class TimersProvider extends StateNotifier<TimerModel> {
  TimersProvider()
      : super(const TimerModel(mins: 0, secs: 0, isRunning: false)) {
    // Initialize with the default timer state
  }

  StreamSubscription<int>? _subscription;

  /// Initializes the counter for the given timer index.
  int _initializeCounter() {
    return (state.mins * 60) + state.secs;
  }

  /// Starts the timer at the given index.
  void startTimer() {
    stopTimer(); // Ensure no multiple subscriptions.

    if (!state.isRunning) {
      int counter = _initializeCounter();

      _subscription = Stream.periodic(const Duration(seconds: 1), (int data) {
        if (counter > 0) {
          counter--;
          _updateTimerFromCounter(counter);
        } else {
          stopTimer();
        }
        return data;
      }).listen((_) {});

      state = state.copyWith(isRunning: true);
    }
  }

  /// Updates the timer state based on the current counter value.
  void _updateTimerFromCounter(int counter) {
    final mins = counter ~/ 60;
    final secs = counter % 60;
    state = state.copyWith(mins: mins, secs: secs);
  }

  /// Sets the timer value at the specified index.
  void setTimer(bool isMins, int value) {
    isMins
        ? state = state.copyWith(mins: value)
        : state = state.copyWith(secs: value);
  }

  /// Stops the timer at the given index.
  void stopTimer() {
    _subscription?.cancel();
    _subscription = null; // Clear the subscription.
    state = state.copyWith(isRunning: false);
  }

  /// Resets the timer at the given index.
  void resetTimer() {
    stopTimer();
    state = const TimerModel(mins: 0, secs: 0, isRunning: false);
  }

  /// Removes the timer at the specified index.
  void removeTimer(int index) {
    _subscription?.cancel();
    _subscription = null;
    state = state.copyWith(mins: 0, secs: 0, isRunning: false);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
