import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:promofocus/screens/slide_drawer.dart';
import 'package:promofocus/screens/taskmodel.dart';
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
  bool isPaused = true;
  bool isAddTask = false;
  int currentPageIndex = 0;
  String? textChange;
  List<String> taskList = [];
  TextEditingController controllerTasks = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              isPaused = true;
              remainingTime = 25 * 60;

            });
          }
          if (index == 1) {
            setState(() {
              isPaused = true;
              remainingTime = 5 * 60;

            });
          }
          if (index == 2) {
            setState(() {
              isPaused = true;
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
        Padding(
          padding: const EdgeInsets.only(left: 40,right: 40,top:40,bottom: 40),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(icons: Icons.add,
                    buttonName: "Add Task",
                   // onPressed: ,
                    buttonColor: Colors.brown, onPressed: () {
                    setState(() {
                      isAddTask = true;
                    });
                    },
                  ),
                  const SizedBox(height: 20),
                  Visibility(visible: isAddTask ,child: Container(
                    padding: const EdgeInsets.only(left: 10,right: 10, bottom: 15,top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        TextField(
                            controller: controllerTasks,
                            keyboardType: TextInputType.text,
                            style:
                            const TextStyle(
                                decorationStyle: TextDecorationStyle.dashed),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.blue,
                                alignLabelWithHint: true,
                                hintText: "What Are you Working On?",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                )),
                            onChanged: (newText) {
                              textChange = newText;
                            },
                            onEditingComplete: () {}
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                              //  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Change the button color
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Change the border shape
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // Handle button click here
                              },
                              child: const Text('cancel'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                if(controllerTasks != null)
                                  {
                                    taskList.add(controllerTasks.text);
                                    controllerTasks.clear();
                                  }
                              },
                              style: ButtonStyle(
                                //  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Change the button color
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Change the border shape
                                  ),
                                ),
                              ),
                              child: const Text('save' ,style: TextStyle(color: Colors.cyan)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: true,
                    child: buildTaskList(),
                  )
                ]

              ),
            ),
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
                  style: TextStyle(fontSize: 24, color: Colors.white),
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

  Widget buildTaskList() {
    return
      Container(
        height: 900,
        width:  300,
      padding: const EdgeInsets.only(left: 10,right: 10, bottom: 15,top: 10),
      // decoration: BoxDecoration(
      //  color: Colors.white70,
      //   borderRadius: BorderRadius.circular(10.0),
      //          ),
        child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return ListTile(
            title: Text(task,style: const TextStyle(color: Colors.white),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // IconButton(
                //   icon: const Icon(Icons.edit, color: Colors.white,),
                //   onPressed: () {
                //     // Implement edit task logic here
                //   },
                // ),
                IconButton(
                  icon: const Icon(Icons.delete,color: Colors.white,),
                  onPressed: () {
                    setState(() {
                      taskList.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        },
    ),
      );
  }

}
