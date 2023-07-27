// import 'package:flutter/material.dart';
//
// class authentificator extends StatefulWidget {
//   const authentificator({super.key});
//
//   @override
//   State<authentificator> createState() => _authentificatorState();
// }
//
// class _authentificatorState extends State<authentificator> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.all(25),
//         child: Form(
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'name',
//                   hintText: 'input your name ',
//
//                 ),
//                 validator: (values) {
//                         if (values == null || values.isEmpty) {
//                           return "error in the text";
//                         }else{
//                           return null;
//                         }
//                 }
//               )
//                 const  SizedBox(height: 15),
//                      ElevatedButton(
//                       onPressed: (){},
//                       child:const Text('send')
//                       ),
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }