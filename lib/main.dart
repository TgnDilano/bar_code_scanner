import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:bar_code_scanner/pages/find_history.dart';
import 'package:bar_code_scanner/pages/history.dart';
import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:flutter/material.dart';
import 'package:bar_code_scanner/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MyApp2(),
    );
  }
}


class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  int index = 0;
  final screens = [
    Home(),
    FindHistory(),
    History()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : screens[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white10,
            iconTheme: MaterialStateProperty.all(IconThemeData(color: Colors.white)),
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)
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
            destinations: [
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
