import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/auth/routing.dart';
import '../primary/recharge.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Text(''),
        backgroundColor: Colors.blue[900],
        title: Text("Wallet"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left:20,top: 20),
                   width: 420,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 420,
                        child: Text(
                            "Balance:",
                        style: TextStyle(
                            fontSize: 30),
                        textAlign: TextAlign.left,),
                      ),
                      Container(

                        child: Text(
                          walletBalance.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Recharge()));
                              },
                              child: Container(
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red[900]
                                ),
                                child: Center(
                                  child: Text(
                                      "Add Money",
                                  style: TextStyle(
                                      fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            Divider(color: Colors.blue, thickness: 1),
            Text("Payment History",
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 25,)
            ),
            SizedBox(height: 10,),
            Container(
              height: 700,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('amount')
                    .where('userId',isEqualTo: currentUserId).where('verified',isEqualTo: true).orderBy('date',descending: true).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child: Text('no data found'),
                    );
                  }
                  var data = snapshot.data?.docs;
                  return data?.length==0?const Center(
                    child: Text('No Transaction History found !'),
                  ):
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context,int index){
                    return data![index]['image']==''?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                             border: Border.all(color: Colors.grey)
                          //boxShadow: [BoxShadow(offset: Offset(0, 0),spreadRadius: 1,blurRadius: 1,color: Colors.grey)]
                        ),
                        child: ListTile(

                          leading: Icon(Icons.call_made,color: Colors.red,) ,
                          title: Text('RS '+data[index]['amount'].toStringAsFixed(2)+' withdrawed from your Wallet'),
                          subtitle: Text(DateFormat('dd MMM yyyy hh mm aaa').format(data[index]['date'].toDate()),
                        ),
                      ),
                    )):Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                             border: Border.all(color: Colors.grey)
                          //boxShadow: [BoxShadow(offset: Offset(0, 0),spreadRadius: 1,blurRadius: 1,color: Colors.grey)]
                        ),
                        child: ListTile(

                          leading: Icon(Icons.call_received,color: Colors.green,) ,
                          title: Text('RS '+data![index]['amount'].toStringAsFixed(2)+' Added to Wallet'),
                          subtitle: Text(DateFormat('dd MMM yyyy hh mm aaa').format(data[index]['date'].toDate()),
                        ),
                      ),
                    ));

                  });
                }
              ),
            )


          ]
        ),
      ),
    );
  }
}
