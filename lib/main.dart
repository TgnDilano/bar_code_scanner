import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:bar_code_scanner/pages/history.dart';
import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:flutter/material.dart';
import 'package:bar_code_scanner/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
    return  ScreenUtilInit(
        builder:(context, child) => GetMaterialApp(
          initialRoute: '/',
          routes: {
            '/' : (context) => Home(),
            '/add' : (context) => AddTpe(),
            '/remove' : (context) => RemoveTpe(),
            '/history' : (context) => History()
          },
          ),
      designSize: const Size(360, 640),
    );
  }
}


