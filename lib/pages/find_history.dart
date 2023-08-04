import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindHistory extends StatefulWidget {
  const FindHistory({super.key});

  @override
  State<FindHistory> createState() => _FindHistoryState();
}


class _FindHistoryState extends State<FindHistory> {

  CollectionReference outStock = FirebaseFirestore.instance.collection("outStock");
  late Stream<QuerySnapshot> _Withdraw;

  @override
  void initState() {
    super.initState();
    _Withdraw = outStock.snapshots();
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Card(
          child: TextField(
            decoration:const  InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'search....',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _Withdraw,
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
                  if(name.isEmpty) {
                    return Card(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(20),
                        height:  MediaQuery.of(context).size.height/2,
                        color: Colors.white70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const  Text('Client Name:',
                                  style: TextStyle(fontWeight: FontWeight.bold),),
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
                                children: [
                                const   Text('client Address:', style: TextStyle(
                                      fontWeight: FontWeight.bold)),
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
                               const  Text('client Tel:', style: TextStyle(
                                    fontWeight: FontWeight.bold)),
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
                                Text('SN', style: TextStyle(
                                    fontWeight: FontWeight.bold)),
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
                      ),
                    );
                  }
                  if (document['client Name'].toString().startsWith(name.toLowerCase())){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.all(20),
                      height: 210,
                      color: Colors.white70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           const    Text('Client Name:',
                                style: TextStyle(fontWeight: FontWeight.bold),),
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
                              children: [
                              const  Text('client Address:', style: TextStyle(
                                    fontWeight: FontWeight.bold)),
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
                            const   Text('client Tel:', style: TextStyle(
                                  fontWeight: FontWeight.bold)),
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
                            const   Text('SN', style: TextStyle(
                                  fontWeight: FontWeight.bold)),
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
                             const  Text('Transaction made By ;', style: TextStyle(
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
                    );
                  }
                }
            );
          }
          return const Center(child:  CircularProgressIndicator());
        },
      ),
    );
  }
}
