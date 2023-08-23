import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:promofocus/screens/slide_drawer.dart';
import 'dart:async';
import '../services/notification_service.dart';
import '../widgets/custom_button_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  String? textChange;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

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
          NotificationApi.showNotification(
            title: "Time\'s up!",
            body: "Your time is up! ",
            payload: "sarag",
          );
        }
        // if (remainingTime <= 24 * 60) {
        //   timer?.cancel();
        //   NotificationApi.showNotification(
        //     title: "Time\'s up!",
        //     body: "Your time is up! Now you can take a short leave. ",
        //     payload: "sarag",
        //   );
        // }
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 2.0,
        backgroundColor: HexColor('#BA4949'),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.menu, // The hamburger icon
        //     color: Colors.white, // Change this color to your desired color
        //   ),
        //   onPressed: () {
        //     _openEndDrawer();
        //   },
        // ),
      ),
      drawer: const SizedBox(
        child: CustomDrawerWidget(),
      ),
      backgroundColor: HexColor('#BA4949'),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          if (index == 0) {
            setState(() {
              remainingTime = 25 * 60;
            });
          }
          if (index == 1) {
            setState(() {
              remainingTime = 5 * 60;
            });
          }
          if (index == 2) {
            setState(() {
              remainingTime = 15 * 60;
            });
          }
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.work),
            label: 'Work',
          ),
          NavigationDestination(
            icon: Icon(Icons.bed_outlined),
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
              GestureDetector(
                onTap: () {
                  _showModalDialog(context);
                },
                child: Text(
                  '$minutes:${seconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              CustomButtonWidget(
                buttonName: isPaused ? "START" : "PAUSE",
                onPressed: isPaused ? resumeTimer : pauseTimer,
                buttonColor: Colors.white38,
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
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              // if (!isPaused)
              CustomButtonWidget(
                buttonName: isPaused ? "START" : "PAUSE",
                onPressed: isPaused ? resumeTimer : pauseTimer,
                buttonColor: Colors.brown,
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
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
    );
  }

  void _showModalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Change time')),
          content: TextField(
              // keyboardType: TextInputType.datetime,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style:
                  const TextStyle(decorationStyle: TextDecorationStyle.dotted),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  focusColor: Colors.blue,
                  alignLabelWithHint: true,
                  hintText: "10",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
              onChanged: (newText) {
                textChange = newText;
              },
              onEditingComplete: () {}),
          //Text('This is a modal dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  var updatedTime = textChange ?? "";
                  int minutes = int.tryParse(updatedTime) ?? 0;
                  remainingTime = minutes * 60;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
