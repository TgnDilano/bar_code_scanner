import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:bar_code_scanner/pages/history.dart';
import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
            padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CustomPaint(
                        size: const Size(20,20),
                        painter:  CirclePainter(),
                        child: const Column(
                          children: [
                             Text(
                              'Hello there!',
                              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
                            ),
                              SizedBox(height: 30,),
                             Text(
                                'Chose the action to be performed..',
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                              ),
                              ),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(height:30),
                  ],
                ),

                                   // Image container
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/illustration.png'))
                  ),
                ),

                                   // Buttons box
                SizedBox(
                    height: MediaQuery.of(context).size.height/3,
                    child:  Column(
                      children: [
                        MaterialButton(
                          height:30,
                          padding: const EdgeInsets.only(left: 50, top: 3, right: 50, bottom: 3),
                          onPressed: ()  {
                            Get.to(() => const AddTpe(), transition: Transition.fade);
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            side: const BorderSide(color: Colors.green, width: 2)
                          ),
                          child: const Text("Add ",style: TextStyle(
                              fontWeight: FontWeight.w400,fontSize: 22,color: Colors.green
                          ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                           MaterialButton(
                             padding:const EdgeInsets.only(left: 30, top: 3, right: 30, bottom: 3),
                             height:30,
                              onPressed: ()  {
                                Get.to(() => const RemoveTpe(), transition: Transition.fade);
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: const BorderSide(color: Colors.green, width: 2)
                              ),
                              child: const Text("Withdraw",style: TextStyle(
                                  fontWeight: FontWeight.w400,fontSize: 22,color: Colors.green
                              ),
                              ),
                            ),
                        const SizedBox(height: 15,),
                        MaterialButton(
                          padding:const EdgeInsets.only(left: 45, top: 3, right: 45, bottom: 3),
                          height:30,
                          onPressed: ()  {
                            Get.to(() => const History(), transition: Transition.fade);
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: const BorderSide(color: Colors.green, width: 2)
                          ),
                          child: const Text("History",style: TextStyle(
                              fontWeight: FontWeight.w400,fontSize: 22,color: Colors.green
                          ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
      ),
    );
  }
}



class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawRect(Rect.fromCenter(center: center, width: 500, height: 500),paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}