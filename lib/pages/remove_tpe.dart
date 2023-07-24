import 'package:flutter/material.dart';

class RemoveTpe extends StatefulWidget {
  const RemoveTpe({super.key});

  @override
  State<RemoveTpe> createState() => _RemoveTpeState();
}

class _RemoveTpeState extends State<RemoveTpe> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            'remove TPE',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.white70),
          ),                  
        ),
        body: Container(
            margin: const EdgeInsets.all(15),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:  const InputDecoration(
                        labelText: "NAME",
                        hintText: "please enter your name",
                        border: OutlineInputBorder(),
                      ),
                      //validation du champ
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "error in the text";
                        }else{
                          return null;
                        }
                      },
                    ),
                    const  SizedBox(height: 15),
                   
                  TextFormField(
                      decoration:  const InputDecoration(
                        labelText: "phone number",
                        hintText: "please enter your phone number",
                        border: OutlineInputBorder(),
                      ),
                      //validation du champ
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "error in the text";
                        }else{
                          return null;
                      
                        }
                        },
                    ),
                   const  SizedBox(height: 15),
                  TextFormField(
                      decoration:  const InputDecoration(
                        labelText: "Adress",
                        hintText: "please enter your Adress",
                        border: OutlineInputBorder(),
                      ),
                      //validation du champ
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "error in the text";
                        }else{
                          return null;
                        }
                      },
                    ),
                    const  SizedBox(height: 15),
                     ElevatedButton(
                      onPressed: (){}, 
                      child:const Text('send')
                      ),
                  ],
                )
                )
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: (){}, 
                  label:const Text('scan'),
                  icon: const Icon(Icons.camera),
                  ),
    
    );
  }
}
