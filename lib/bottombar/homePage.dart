import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/primary/bookingPage.dart';
import 'package:untitled1/primary/data.dart';

setSearchParam(String caseNumber) {
  List<String> caseSearchList = <String>[];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;

}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController stationName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Home'),
      ),
      body: Column(
        children: [
          //searchbar
          Container(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: TextField(
              controller: stationName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'search charging stations',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: stationName.text == ""
                  ? FirebaseFirestore.instance
                      .collection('stations')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('stations')
                      .where('search',
                          arrayContains: stationName.text.toUpperCase())
                      .snapshots(),
              builder: (context, snapshot) {
                var datas = snapshot.data?.docs;

                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    color: Colors.indigo,
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: datas?.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Booking(
                                            name: datas?[index]['name'],
                                            place: datas?[index]['place'],
                                            distance: data[index]['distance'],
                                            rating: data[index]['rating'],
                                            id: datas?[index]['id'],
                                            address: datas?[index]['address'],
                                            unitprice: datas?[index]
                                                ['pricePerUnit'],
                                            charginfTypes: datas?[index]
                                                ['chargingTypes'],
                                            time: datas?[index]["time"],
                                            data: datas![index],
                                            location: datas?[index]["location"],
                                        availablity: datas?[index]["available"],
                                        availableTill: datas?[index]["openTill"],availbleFrom: datas?[index]["openFrom"],
                                          )));
                            },
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 0,
                                        spreadRadius: 1,
                                        color: Colors.grey)
                                  ],
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  ///image

                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/charge.jpeg"),
                                            fit: BoxFit.contain)),
                                  ),

                                  ///details
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // border: Border.all()
                                          ),
                                      // width: 290,
                                      height: 150,
                                      child: Column(
                                        children: [
                                          Text(
                                            datas?[index]['name'],
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            datas?[index]['place'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            data?[index]['distance'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            "${data[index]['rating']}/5",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
