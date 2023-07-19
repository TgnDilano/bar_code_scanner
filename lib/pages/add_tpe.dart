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
  var success = const  SnackBar(content: Text('TPE added successfully'));
  var error = const  SnackBar(content: Text('please scan the Bar code '));

  // to add collection i first create a collection reference
 CollectionReference Stock = FirebaseFirestore.instance.collection('Stock');

   //creating the scan Barcode Function
  String  _scanBarcodeResult = " ";
  Future<void> scanBarcode() async {
    String Result;
    try{
      Result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE
      );
      debugPrint(Result);
    } on PlatformException{
     Result = 'failed to find platformed version';
    }
    if(!mounted) return;
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
        height: MediaQuery.of(context).size.height,
        padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' $_scanBarcodeResult'),
            ElevatedButton.icon(
                onPressed: scanBarcode,
                icon: const  Icon(Icons.camera_alt),
                label: const Text(
                    'Scan Bar Code',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize: 22,
                  ),
                )
            ),
            const SizedBox(height: 30,),
            MaterialButton(
              minWidth: double.infinity,
              height:70,
              onPressed: () async {
                if(_scanBarcodeResult == " "){
                ScaffoldMessenger.of(context).showSnackBar(error);
                } else{
                  await Stock.add({ 'IMEI':_scanBarcodeResult }).then((value) =>  ScaffoldMessenger.of(context).showSnackBar(success));
                }
              },
              color: Colors.green[600],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              child: const Text("Add TPE",style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white70
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
