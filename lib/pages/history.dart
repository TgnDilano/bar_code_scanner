import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  CollectionReference outStock = FirebaseFirestore.instance.collection('outStock');
 late Stream<QuerySnapshot> _streamWithdrawal;

@override
  void initState() {
    super.initState();
    _streamWithdrawal = outStock.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: Colors.green.shade500,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _streamWithdrawal,
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
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Client Name:', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                document['client Name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 21,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                              Text('client Address:',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              document['client Address'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            ]
                          ),
                          const SizedBox(height: 21,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('client Tel:', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                document['client Phone Number'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 21,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const  Text('Duration:', style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                              Text(
                                document['Duration'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 21,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SN', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                document['SN'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 21,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const   Text('Transaction made By ;', style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                              Text(
                                document['sellers'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ],
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


