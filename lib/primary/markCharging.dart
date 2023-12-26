import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/auth/routing.dart';
class Mark extends StatefulWidget {
  final String id;
  final String stationId;
  final String stationName;
  final String date;
  final double amount;
  const Mark({Key? key, required this.stationId, required this.stationName,required this.date, required this.amount, required this.id,}) : super(key: key);

  @override
  State<Mark> createState() => _MarkState();
}

class _MarkState extends State<Mark> {

  int userRating=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Mark Booking'),
        centerTitle: true,
      ), 
      bottomSheet: InkWell(
        onTap: (){
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Rate us"),
              content: Container(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                    userRating=rating.round();
                  },
                  )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if(userRating!=0){
                      FirebaseFirestore.instance
                          .collection('rating')
                          .doc(widget.id)
                          .set({
                        'rating':userRating,
                        'userName':currentUserName,
                        'stationId':widget.stationId,
                        'userId':currentUserId
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Rating added successfully'),));


                    }
                    Navigator.pop(context);
                    },
                  child: Container(
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.all(14),
                    child: const Text("okay"),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          color: Colors.blue[900],
          height: 50,
          child: Center(child: Text("Mark as Done",style: TextStyle(color: Colors.white, fontSize: 20),)),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("Booking Details", style: TextStyle(fontSize: 25),),
              SizedBox(height:30 ,),

              Text(widget.stationName, style: TextStyle(fontSize: 20),),
              Text(widget.date, style: TextStyle(fontSize: 20),),
              Text(widget.amount.toStringAsFixed(2), style: TextStyle(fontSize: 20),),

            ],
          ),
        ),
      ),
    );
  }
}
