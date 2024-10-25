import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_stopwatch/ui/scroll_wheel.dart';
import 'package:riverpod_stopwatch/providers/timer_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// StateNotifier to manage individual timer states

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CountDownTimer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CountDownTimer extends ConsumerWidget {
  const CountDownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            onPressed: () {
              timer.isRunning
                  ? timerNotifier.stopTimer()
                  : timerNotifier.startTimer();
            },
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 120,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xff0395eb),
                  width: 4,
                ),
              ),
              child: timer.isRunning
                  ? Text(
                      '${timer.mins.toString().padLeft(2, '0')}:${timer.secs.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ScrollWheel(
                            isMins: true,
                            value: timer.mins,
                          ),
                        ),
                        const Text(
                          ':',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ScrollWheel(
                            isMins: false,
                            value: timer.secs,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          CupertinoButton(
            onPressed: () => timerNotifier.resetTimer(),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Reset",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
