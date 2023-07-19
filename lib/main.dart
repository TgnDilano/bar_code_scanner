import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:flutter/material.dart';
import 'package:bar_code_scanner/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( GetMaterialApp(
    initialRoute: '/',
    routes: {
      '/' : (context) => const Home(),
      '/add' : (context) => const AddTpe(),
      '/remove' : (context) => const RemoveTpe()
    },
  ));
}

