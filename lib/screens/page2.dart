import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

import '../widgets/custom_button_widget.dart';

class CountdownTimerApp2 extends StatefulWidget {
  const CountdownTimerApp2({super.key});

  @override
  _CountdownTimerApp2State createState() => _CountdownTimerApp2State();
}

class _CountdownTimerApp2State extends State<CountdownTimerApp2> {
  int initialTime = 25 * 60;
  int remainingTime = 25 * 60;
  Timer? timer;
  bool isPaused = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (!isPaused && remainingTime > 0) {
          remainingTime--;
        }
        if (remainingTime <= 0) {
          timer?.cancel();
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
    timer?.cancel();
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = remainingTime ~/ 60;
    int seconds = remainingTime % 60;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'PromoFocus',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$minutes:${seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // if (!isPaused)
            CustomButtonWidget(
              buttonName: isPaused ? "START" : "PAUSE",
              onPressed: isPaused ? resumeTimer : pauseTimer,
              buttonColor: Colors.black38,
            ),
            if (remainingTime == 0)
              const Text(
                'Time\'s up!',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
