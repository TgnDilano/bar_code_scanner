import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:bar_code_scanner/pages/find_history.dart';
import 'package:bar_code_scanner/pages/history.dart';
import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return  Scaffold(
      body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/2,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/pic1.png'))
                      ),
                    ),
                    const SizedBox(height:60),
                    MaterialButton(
                      padding: const EdgeInsets.only(left: 130, top: 3, right: 130, bottom: 3),
                      height: 40,
                      onPressed: (){
                        Get.to(() => const AddTpe(), transition: Transition.fade);
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: const BorderSide(color: Colors.green, width: 2)
                      ),
                      child: const Text(
                        "Add", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: Colors.green
                      ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(
                      padding: const EdgeInsets.only(left: 100, top: 3, right: 100, bottom: 3),
                      height: 40,
                      onPressed: (){
                        Get.to(() => const RemoveTpe(), transition: Transition.fade);
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: const BorderSide(color: Colors.green, width: 2)
                      ),
                      child: const Text(
                        "Withdraw", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: Colors.green
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}
