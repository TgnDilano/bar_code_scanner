
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bar_code_scanner/pages/add_tpe.dart';

class RemoveTpe extends StatefulWidget {
  const RemoveTpe({super.key});

  @override
   State<RemoveTpe> createState() => _RemoveTpeState();

}

class _RemoveTpeState extends State<RemoveTpe> {
  // CollectionReference outStock= FirebaseFirestore.instance.collection('outStock');
 bool isLoading = false;
  //creating a snackbar to display a message to the user
  var error = const SnackBar(content: Text('please scan the Bar code '));
  var doesNotExist = const SnackBar(content: Text('Sorry, but this device does not exist'));


  // creating controllers to store value from the TextFieldForm
              final _NameController = TextEditingController();
              final _NumberController = TextEditingController();
              final _AddressController = TextEditingController();
              final _durationController = TextEditingController();
              final _sellerController = TextEditingController();


              void dispose() {
                _NameController.dispose();
                _NumberController.dispose();
                _AddressController.dispose();
                _durationController.dispose();
                _sellerController.dispose();
                super.dispose();
              }

              // Function to execute our database database operation
              Future outStock(String clientName, int number, String address, String duration, String sellers,
                  Future? future) async {
                await FirebaseFirestore.instance.collection('outStock').add({
                  'client Name': clientName,
                  'client Phone Number': number,
                  'client Address': address,
                  'Duration' : duration,
                  'sellers': sellers,
                  'SN': _scanBarcodeResult,
                  'Done on the' : Timestamp.now()
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
                EasyLoading.show(status: 'please wait...');
                if(_scanBarcodeResult == " ") {
                  // EasyLoading.show(status: 'please wait...');
                  EasyLoading.showError('please Scan the Bar code');
                  EasyLoading.dismiss();
                } else {
                  final QuerySnapshot ifExist;
                  ifExist =
                  await FirebaseFirestore.instance.collection('Stock').where(
                      'SN', isEqualTo: _scanBarcodeResult).get();
                  final List <DocumentSnapshot> documents = ifExist.docs;
                  if (documents.isEmpty) {
                    EasyLoading.show(status: 'please wait...');
                    EasyLoading.showError('Sorry, but this device does not exist');
                    EasyLoading.dismiss();
                  } else {
                    outStock(
                      _NameController.text.trim(),
                      int.parse(_NumberController.text.trim()),
                      _AddressController.text.trim(),
                      _durationController.text.trim(),
                      _sellerController.text.trim(),
                      Get.to(() => const RemoveTpe(),
                          transition: Transition.fade),
                    );
                    final QuerySnapshot rs;
                    rs =
                    await FirebaseFirestore.instance.collection('Stock').where(
                        'SN', isEqualTo: _scanBarcodeResult).get();
                    rs.docs.forEach((doc) {
                      doc.reference.delete();
                    });
                    setState(() {
                      _NameController.clear();
                      _AddressController.clear();
                      _NumberController.clear();
                      _durationController.clear();
                      _sellerController.clear();
                      _scanBarcodeResult = " ";
                    });
                    EasyLoading.showSuccess('Done');
                    EasyLoading.dismiss();
                  }
                }
                 }

              //creating the scan Barcode Function
              String _scanBarcodeResult = " ";
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
                        // height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10,),
                                Container(
                                  // height: MediaQuery.of(context).size.height/1,
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
                                      SizedBox(height: 21),
                                      TextFormField(
                                        controller: _durationController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                              "Duration",
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
                                      SizedBox(height: 10),
                                      TextFormField(
                                        controller: _sellerController,
                                        decoration: const InputDecoration(
                                            label: Text(
                                              "Transaction made by : ",
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
                                      const  Text(
                                        'SN',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(bottom:25, top: 40),
                                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                                        color: Colors.white70,
                                        // height: MediaQuery.of(context).size.height/15,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text( _scanBarcodeResult),
                                            const  SizedBox(height: 15,),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: scanBarcode,
                                                    icon: Icon(Icons.camera_alt,)
                                                ),
                                                IconButton(
                                                    onPressed: (){
                                                      setState(() {
                                                        _scanBarcodeResult = " ";
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete, color: Colors.red,)
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      MaterialButton(
                                        padding: const EdgeInsets.only(left: 100, top: 3, right: 100, bottom: 3),
                                        height: 40,
                                        onPressed: removeTpe,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(40),
                                            side: const BorderSide(color: Colors.green, width: 2)
                                        ),
                                        child: isLoading?const  CircularProgressIndicator(color:Colors.green,) : const Text(
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
                );
              }
            }



