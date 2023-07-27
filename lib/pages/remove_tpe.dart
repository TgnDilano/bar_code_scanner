import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bar_code_scanner/pages/add_tpe.dart';

class RemoveTpe extends StatefulWidget {
  const RemoveTpe({super.key});

  @override
            _RemoveTpeState createState() => _RemoveTpeState();

}

class _RemoveTpeState extends State<RemoveTpe> {
  // CollectionReference outStock= FirebaseFirestore.instance.collection('outStock');

  //creating a snackbar to display a message to the user
  var error = const SnackBar(content: Text('please scan the Bar code '));
  var exist = const SnackBar(content: Text('Sorry, but this device has being withdraw already please Withdraw a new device'));


  // creating controllers to store value from the TextFieldForm
              final _NameController = TextEditingController();
              final _NumberController = TextEditingController();
              final _AddressController = TextEditingController();

              void dispose() {
                _NameController.dispose();
                _NumberController.dispose();
                _AddressController.dispose();
                super.dispose();
              }

              // Function to execute our database database operation
              Future outStock(String clientName, int number, String address,
                  Future? future) async {
                await FirebaseFirestore.instance.collection('outStock').add({
                  'client Name': clientName,
                  'client Phone Number': number,
                  'client Address': address,
                  'Top IMEI': _scanBarcodeResult,
                  'Bottom IMEI': _scanBarcodeResult2
                }
                ).whenComplete(() =>
                    Get.snackbar("success", "Added to outStock successfully",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white,
                    )).catchError((error, stackTrace) {
                  Get.snackbar("ERROR", "failed to add",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.redAccent.withOpacity(0.1)
                  );
                });
              }

              // function that run when the button is clicked
              Future removeTpe() async {
                final QuerySnapshot rs;
                rs = await FirebaseFirestore.instance.collection('outStock').where('Top IMEI', isEqualTo: _scanBarcodeResult).get();
                final List < DocumentSnapshot > documents = rs.docs;
                if (_scanBarcodeResult == " " && _scanBarcodeResult2 == " ") {
                  ScaffoldMessenger.of(context).showSnackBar(error);
                } if(documents.isEmpty){
                  setState(() {
                    outStock(
                      _NameController.text.trim(),
                      int.parse(_NumberController.text.trim()),
                      _AddressController.text.trim(),
                      Get.to(() => const RemoveTpe(), transition: Transition.fade),
                    );
                    _NameController.clear();
                    _AddressController.clear();
                    _NumberController.clear();
                    _scanBarcodeResult2 = " ";
                    _scanBarcodeResult = " ";
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(exist);
                }
              }

              //creating the scan Barcode Function
              String _scanBarcodeResult = " ";
              String _scanBarcodeResult2 = " ";
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
                String Result2;
                Result2 = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666',
                    'Cancel',
                    true,
                    ScanMode.BARCODE
                );
                debugPrint(Result2);
                if (!mounted) return;
                setState(() {
                  _scanBarcodeResult = Result;
                  _scanBarcodeResult2 = Result2;
                });
              }

              @override
              Widget build(BuildContext context) {
                ScreenUtil.init(context, designSize: const Size(360, 690));
                bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.green,
                      title: const Text(
                        "Withdraw",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white70
                        ),
                      ),
                    ),
                    body: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 30),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height / 4,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(image: AssetImage(
                                          'assets/illustration.png'))
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _NameController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                              "Client  Name",
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2,
                                                )
                                            )
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Client Name";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20,),
                                      TextFormField(
                                        controller: _NumberController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                              "Client Phone Number",
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2,
                                                )
                                            )
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "please Enter the Phone Number";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20,),
                                      TextFormField(
                                        controller: _AddressController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                              "Client Address",
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2,
                                                )
                                            )
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Client Address";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(_scanBarcodeResult),
                                      Text(_scanBarcodeResult2),
                                      MaterialButton(
                                        padding: const EdgeInsets.only(left: 30, top: 3, right: 30, bottom: 3),
                                        height: 30,
                                        onPressed: removeTpe,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                40),
                                            side: const BorderSide(color: Colors
                                                .green, width: 2)
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
                                )
                              ],
                            ),
                          ),
                        )
                    ),

                  // scanning button
                  floatingActionButton: Visibility(
                    visible: !showFab,
                    child: FloatingActionButton.extended(
                    onPressed: scanBarcode,
                    icon: const  Icon(Icons.camera_alt),
                    label:  const Text('Scan'),
                    backgroundColor: Colors.green,
                ),
                  ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                );
              }
            }



