import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_stopwatch/providers/timer_provider.dart';

class ScrollWheel extends ConsumerWidget {
  final bool isMins;
  final int value;
  const ScrollWheel({super.key, required this.isMins, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerNotifier = ref.read(timerProvider.notifier);

    return CupertinoPicker(
      itemExtent: 38.0,
      onSelectedItemChanged: (value) {
        timerNotifier.setTimer(isMins, value);
      },
      children: List<Widget>.generate(60, (int index) {
        return Center(
          child: Text(value.toString()),
        );
      }),
    );
  }
}
