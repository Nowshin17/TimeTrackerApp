import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:promofocus/screens/page1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Configure the notification plugin
  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    // iOS: IOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // ),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: HexColor('#BA4949')),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 0;
    return const CountdownTimerApp();
    //   Scaffold(
    //  bottomNavigationBar: NavigationBar(
    //     onDestinationSelected: (int index) {
    //       setState(() {
    //         currentPageIndex = index;
    //       });
    //     },
    //     selectedIndex: currentPageIndex,
    //     destinations: const <Widget>[
    //       NavigationDestination(
    //         icon: Icon(Icons.work),
    //         label: 'Promodoro',
    //       ),
    //       NavigationDestination(
    //         icon: Icon(Icons.bed),
    //         label: 'Short Break',
    //       ),
    //       NavigationDestination(
    //         selectedIcon: Icon(Icons.bookmark),
    //         icon: Icon(Icons.bookmark_border),
    //         label: 'Long Break',
    //       ),
    //     ],
    //   ),
    //   body: <Widget>[
    //     const CountdownTimerApp()
    //      ,
    //     const CountdownTimerApp2(),
    //     const CountdownTimerApp2()
    //   ][currentPageIndex],
    // );
  }
}
