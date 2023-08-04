import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddTpe extends StatefulWidget {
  const AddTpe({super.key});

  @override
  State<AddTpe> createState() => _AddTpeState();
}

class _AddTpeState extends State<AddTpe> {
   bool _iconBool = false;

  IconData _iconCamera = Icons.camera_alt;
  IconData _iconDelete = Icons.delete;




  var success = const  SnackBar(content: Text('TPE added successfully'));
  var error = const  SnackBar(content: Text('please scan the Bar code '));
  var exist = const SnackBar(content: Text('Sorry, but this device exist already please Add a new device'));

  // to add collection i first create a collection reference
 CollectionReference Stock = FirebaseFirestore.instance.collection('Stock');


 // this function check if the device exist , ifNotExist it add a new device to stock
 AddTpe() async {
final QuerySnapshot rs;
   rs = await FirebaseFirestore.instance.collection('Stock').where('SN', isEqualTo: _scanBarcodeResult).get();
final List < DocumentSnapshot > documents = rs.docs;
if(_scanBarcodeResult == " "){
  ScaffoldMessenger.of(context).showSnackBar(error);
}
if( documents.isEmpty){
  setState(() async {
    await Stock.add({ 'SN':_scanBarcodeResult, })
        .then((value) =>  ScaffoldMessenger.of(context).showSnackBar(success));
  });

} else {
  ScaffoldMessenger.of(context).showSnackBar(exist);
}
 }

  // //creating the scan Barcode Function
  String  _scanBarcodeResult = " ";
  Future<void> scanBarcode() async {
    String Result;
      try {
        Result = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666',
            'Cancel',
            true,
            ScanMode.BARCODE
        );
        debugPrint(Result);
      } on PlatformException {
        Result = 'failed to find platformed version';
      }
      if (!mounted) return;
      setState(() {
        _scanBarcodeResult = Result;
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text(
          'Add TPE',
          style: TextStyle(
              fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white70
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height,
        padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/illustration.png'))
                ),
              ),
             const  Text(
                'SN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom:25, top: 25),
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                color: Colors.white70,
                height: MediaQuery.of(context).size.height/12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( _scanBarcodeResult),
                   const  SizedBox(height: 15,),
                    Row(
                      children: [
                        IconButton(
                            onPressed: scanBarcode,
                            icon: Icon(_iconBool ? _iconDelete: _iconCamera,)
                        ),
                        // IconButton(
                        //     onPressed: (){
                        //       setState(() {
                        //         _scanBarcodeResult = " ";
                        //       });
                        //     },
                        //     icon: Icon(_iconBool ? _iconCamera : _iconDelete,)
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              MaterialButton(
                padding: const EdgeInsets.only(left: 130, top: 3, right: 130, bottom: 3),
                height:40,
                onPressed : AddTpe,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: Colors.green,width: 2)
                ),
                child: const Text("Add ",style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 22,color: Colors.green
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
