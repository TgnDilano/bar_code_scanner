import 'dart:async';

import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:bar_code_scanner/pages/find_history.dart';
import 'package:bar_code_scanner/pages/withdrawer_history.dart';
import 'package:bar_code_scanner/pages/history_screens.dart';
import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:flutter/material.dart';
import 'package:bar_code_scanner/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: MyApp2(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
}



class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }
  int index = 0;
  final screens = [
   const Home(),
   const FindHistory(),
   const history_screens()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : screens[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(30.0), ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white10,
            iconTheme: MaterialStateProperty.all(const IconThemeData(color: Colors.white)),
            labelTextStyle: MaterialStateProperty.all(
             const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)
            ),
            backgroundColor: Colors.green.shade500,
          ),
          child: NavigationBar(
            height: 60,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() {
                  this.index = index;
                }),
            destinations: const [
             NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home_filled),
                  label: 'Home'
              ),
              NavigationDestination(
                  icon: Icon(Icons.search),
                  selectedIcon: Icon(Icons.youtube_searched_for),
                  label: 'Search'
              ),
              NavigationDestination(
                  icon: Icon(Icons.history),
                  selectedIcon: Icon(Icons.history_rounded),
                  label: 'history'
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
//
//
//
// class _MyAppState extends State<MyApp> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         builder:(context, child) => GetMaterialApp(
//           initialRoute: '/',
//           routes: {
//             '/' : (context) => Home(),
//             '/add' : (context) => AddTpe(),
//             '/remove' : (context) => RemoveTpe(),
//             '/history' : (context) => History(),
//             '/search' : (context) => FindHistory()
//           },
//           ),
//       designSize: const Size(360, 640),
//     );
//   }
// }
//
//
