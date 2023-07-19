import 'package:bar_code_scanner/pages/add_tpe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                   const Text(
                        'Hello there!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  const  SizedBox(height: 30,),
                    Text(
                      'Chose the action to be performed..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15
                    ),
                    ),
                    const SizedBox(height:30),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/illustration.png'))
                  ),
                ),
                MaterialButton(
                minWidth: double.infinity,
                height:70,
                onPressed: (){
                  Get.to(() => const AddTpe(), transition: Transition.fade);
                },
                color: Colors.green[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                ),
                child: const Text("Add TPE",style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white70
                ),
                ),
              ),
                MaterialButton(
                  minWidth: double.infinity,
                  height:70,
                  onPressed: (){

                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: const Text("Remove TPE",style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white70
                  ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
