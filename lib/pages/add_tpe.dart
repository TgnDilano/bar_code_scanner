import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get_core/src/get_main.dart';

class AddTpe extends StatefulWidget {
  const AddTpe({super.key});

  @override
  State<AddTpe> createState() => _AddTpeState();
}

class _AddTpeState extends State<AddTpe> {
  var success = const  SnackBar(content: Text('TPE added successfully'));
  var error = const  SnackBar(content: Text('please scan the Bar code '));
  var exist = const SnackBar(content: Text('Sorry, but this device exist already please Add a new device'));

  // to add collection i first create a collection reference
 CollectionReference Stock = FirebaseFirestore.instance.collection('Stock');


 // this function check if the device exist , ifNotExist it add a new device to stock
 AddTpe() async {
final QuerySnapshot rs;
   rs = await FirebaseFirestore.instance.collection('Stock').where('Top IMEI', isEqualTo: _scanBarcodeResult).get();
final List < DocumentSnapshot > documents = rs.docs;
if(_scanBarcodeResult == " " && _scanBarcodeResult2 == " "){
  ScaffoldMessenger.of(context).showSnackBar(error);
}
if( documents.isEmpty){
  setState(() async {
    await Stock.add({ 'Top IMEI':_scanBarcodeResult, 'Bottom IMEI':_scanBarcodeResult2 })
        .then((value) =>  ScaffoldMessenger.of(context).showSnackBar(success));


  });

} else {
  ScaffoldMessenger.of(context).showSnackBar(exist);

}
 }


  // //creating the scan Barcode Function
  String  _scanBarcodeResult = " ";
  String _scanBarcodeResult2 = " ";
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
    String Result2;
    Result2 = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE
    );
    debugPrint(Result2);
    if(!mounted) return;
    setState(() {
      _scanBarcodeResult = Result;
      _scanBarcodeResult2 = Result2;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/illustration.png'))
              ),
            ),
            Text( _scanBarcodeResult),
            Text(_scanBarcodeResult2),
            // ElevatedButton.icon(
            //     onPressed: scanBarcode,
            //     icon: const  Icon(Icons.camera_alt),
            //     label: const Text(
            //         'Scan Bar Code',
            //       style: TextStyle(
            //           fontWeight: FontWeight.w600,fontSize: 22,
            //       ),
            //     )
            // ),
            const SizedBox(height: 30,),
            MaterialButton(
              padding:const EdgeInsets.only(left: 45, top: 5, right: 45, bottom: 5),
              height:30,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: scanBarcode,
        icon: const  Icon(Icons.camera_alt),
        label:  const Text('Scan'),
        backgroundColor: Colors.green,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
