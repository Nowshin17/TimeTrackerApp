import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

import '../widgets/custom_button_widget.dart';

class CountdownTimerApp extends StatefulWidget {
  const CountdownTimerApp({super.key});

  @override
  _CountdownTimerAppState createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  int initialTime = 25 * 60;
  int remainingTime = 25 * 60;
  Timer? timer;
  bool isPaused = false;
  int currentPageIndex = 0;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (!isPaused && remainingTime > 0) {
          remainingTime--;
        }
        if (remainingTime == 8 * 60) {
          timer?.cancel();
          setState(() {
            isPaused = true;
          });
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
        backgroundColor: HexColor('#BA4949'),
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          print(index);
          if(index == 0)
          {
            print("ok");
            setState(() {
              remainingTime = 25 * 60;
              print(remainingTime);
            });
          }
          if(index == 1)
          {
            print("ok");
            setState(() {
              remainingTime = 5 * 60;
               print(remainingTime);
            });
          }
          if(index == 2)
          {
            print("ok");
            setState(() {
              remainingTime = 15 * 60;
              print(remainingTime);
            });
          }
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.work),
            label: 'Promodoro',
          ),
          NavigationDestination(
            icon: Icon(Icons.bed),
            label: 'Short Break',
          ),
          NavigationDestination(
            // selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Long Break',
          ),
        ],
      ),
      body: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutes:${seconds.toString().padLeft(2, '0')}',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutes:${seconds.toString().padLeft(2, '0')}',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // if (!isPaused)
              CustomButtonWidget(
                buttonName: isPaused ? "START" : "PAUSE",
                onPressed: isPaused ? resumeTimer : pauseTimer,
                buttonColor: Colors.cyanAccent,
              ),
              if (remainingTime == 0)
                const Text(
                  'Time\'s up!',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutes:${seconds.toString().padLeft(2, '0')}',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // if (!isPaused)
              CustomButtonWidget(
                buttonName: isPaused ? "START" : "PAUSE",
                onPressed: isPaused ? resumeTimer : pauseTimer,
                buttonColor: Colors.blue,
              ),
              if (remainingTime == 0)
                const Text(
                  'Time\'s up!',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
            ],
          ),
        )
      ][currentPageIndex],
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         '$minutes:${seconds.toString().padLeft(2, '0')}',
      //         style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(height: 20),
      //       // if (!isPaused)
      //       CustomButtonWidget(
      //         buttonName: isPaused ? "START" : "PAUSE",
      //         onPressed: isPaused ? resumeTimer : pauseTimer,
      //         buttonColor: Colors.black38,
      //       ),
      //       if (remainingTime == 0)
      //         const Text(
      //           'Time\'s up!',
      //           style: TextStyle(fontSize: 24, color: Colors.red),
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
