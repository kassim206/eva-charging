import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/auth/routing.dart';
import 'package:untitled1/primary/markCharging.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance
            .collection('booking')
            .where('userEmail',isEqualTo: currentUserEmail)
            .snapshots() ,

        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator(
              color: Colors.indigo,
            );
          }


          var data = snapshot.data?.docs;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                var d =data?[index]["date"];
                var t = d.toDate();

                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Mark(
                      id:data![index].id,
                      stationId:data![index]['stationId'],
                      stationName:data![index]["stationName"],
                      date:DateFormat('hh:mm:a dd/MM/yyyy').format(t),
                      amount:data![index]["estimatePrice"]
                    )));
                  },
                  leading: Icon(Icons.electric_car, color: Colors.blue,),
                  title: Text(data?[index]["stationName"]),
                  subtitle: Text(DateFormat('hh:mm:a dd/MM/yyyy').format(t)),
                  trailing: Text("RS ${(data?[index]["estimatePrice"]).toString().substring(0,5)}"),
                );


          });

        },
      ),
    );
  }
}
