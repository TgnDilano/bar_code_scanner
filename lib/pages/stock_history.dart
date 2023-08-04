import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


class stock_history extends StatefulWidget {
  const stock_history({super.key});

  @override
  State<stock_history> createState() => _stock_historyState();
}

class _stock_historyState extends State<stock_history> {

  CollectionReference Stock = FirebaseFirestore.instance.collection('Stock');
  late Stream<QuerySnapshot> _streamAdd;


  @override
  void initState() {
    super.initState();
    _streamAdd = Stock.snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _streamAdd,
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          if(snapshot.connectionState == ConnectionState.active)
          {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot>listQueryDocumentSnapshots = querySnapshot.docs;

            return ListView.builder(
                itemCount:listQueryDocumentSnapshots.length ,
                itemBuilder:(context, index){
                  QueryDocumentSnapshot document = listQueryDocumentSnapshots[index];
                  return Card(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.all(20),
                      height: 120,
                      color: Colors.white70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(timeago.format(document['Done'].toDate())),
                          // Text(timeago.format(document['Done on the'].toDate())
                          // ),
                          SizedBox(height:30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SN', style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                              Text(
                                document['SN'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) ;
                }
            );
          }
          return const Center(child:  CircularProgressIndicator());
        },
      ),
    );
  }
}
