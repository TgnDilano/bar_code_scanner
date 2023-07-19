import 'package:flutter/material.dart';

class RemoveTpe extends StatefulWidget {
  const RemoveTpe({super.key});

  @override
  State<RemoveTpe> createState() => _RemoveTpeState();
}

class _RemoveTpeState extends State<RemoveTpe> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text(
          'remove TPE',
          style: TextStyle(
              fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white70
          ),
        ),
      ),
      body: Form(
        child: Column(children: [
          TextFormField(
            decoration:InputDecoration(
              labelText: 'nom',
              hintText: 'entrer votre nom',
            )
          )
        ],)
        

        )

      );
  
    
    
  }
}

