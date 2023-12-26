import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:untitled1/auth/routing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'coupons.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.name,
    required this.place, required this.distance,
    required this.rating, required this.id,
    required this.address, required this.unitprice, required this.charginfTypes, required this.time, required this.data, required this.location, required this.availablity, required this.availableTill, required this.availbleFrom}) : super(key: key);
final String name;
final String place;
final DocumentSnapshot data;
final String distance;
final double rating;
final String id;
final String address;
final String unitprice;
final List charginfTypes;
final String time;
final String location;
final bool availablity;
final String availableTill;
final String availbleFrom;

  @override
  State<Booking> createState() => _BookingState();
}
class _BookingState extends State<Booking> {


  int doclength=0;
  int stationRating=0;
  int ratingavg=0;
  double avg=0;
  getStationRating() async {
    QuerySnapshot ratingDocs = await FirebaseFirestore.instance
        .collection('rating')
        .where('stationId', isEqualTo: widget.id)
        .get();

    if(ratingDocs.docs.isNotEmpty){
      doclength=ratingDocs.docs.length??0;
      for(var doc in ratingDocs.docs){
        int rating=doc.get('rating');
        stationRating+=rating;

      }

    }
    setState(() {
      avg=stationRating/doclength;
      ratingavg=(avg).round();
      print(stationRating);
      print(ratingavg);
    });
  }

  @override
  void initState() {
    getStationRating();
    super.initState();
  }

  double estimate=0;
  bool clicked=false;
  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
   var height = size.height;
   var width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Booking'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 220, width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://imgs.search.brave.com/nzuYak3TJJIvwJDOkjqaozNSUycUiUY93647S9VlD8g/rs:fit:626:387:1/g:ce/aHR0cHM6Ly9pbWFn/ZS5mcmVlcGlrLmNv/bS9mcmVlLXZlY3Rv/ci9lbGVjdHJpYy1j/YXItY2hhcmdpbmct/aXRzLWJhdHRlcnkt/d2l0aC1uYXR1cmFs/LWxhbmRzY2FwZS1j/b25jZXB0LWlsbHVz/dHJhdGlvbi1lbnZp/cm9ubWVudF8xMTMw/NjUtMjkuanBn'                          ),
                            fit: BoxFit.cover)),
                  ),
//                 Positioned(
//                     top: 20,
//                     right: 20,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(40),
//                         color: Colors.blue[900],
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           bookmarkIcn,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                         onPressed: () {
//                           if(clicked==false){
//                             print(widget.id);
//                             clicked = true;
//                             bookmarkIcn = savedIcon;
//                             FirebaseFirestore.instance.collection('stations').doc(widget.id).update({
//                               'saved':FieldValue.arrayUnion([currentUserId])
//                             });
//                             setState(() {
//
//                             });
//                           }
//                           else{
//                             print('fdsfdfd');
//                             clicked = false;
//                             bookmarkIcn = saveIcon;
//
//                             FirebaseFirestore.instance.collection('stations').doc(widget.id).update({
//                               'saved':FieldValue.arrayRemove([currentUserId])
//                             });
//                             setState(() {
//
//                             });
//                           }
// setState(() {
//
// });
//
//                           //if()
//
//                           // FirebaseFirestore.instance.collection('saved').a
//                         },
//                       ),
//                     ))
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 30,),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                            widget.place,
                            style: TextStyle(fontSize: 22)),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Open till ${widget.availableTill} pm',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red),),
                        Container(
                          child:widget.availablity== true? Row(
                            children: [
                              Text(
                                " Available", //status
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, color: Colors.green),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.check_circle_outline,color: Colors.green,size: 25,)
                            ],
                          ):
                          Row(
                            children: [
                              Text(
                                " Unavailable", //status
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, color: Colors.red),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.cancel_outlined,color: Colors.red,size: 25,)
                            ],
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.white
                            // ,
                            // // border: Border.all(color: Colors.blueAccent),
                            // boxShadow: [BoxShadow(offset: Offset(0, 0),blurRadius: 5,spreadRadius: 1,color: Colors.grey)],
                            // borderRadius: BorderRadius.circular(15),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),



                SizedBox(height: 10,),


                SizedBox(height: 10,),

              ],
            ),
          )
,


            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                ],
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height*0.2, width: width*0.9,
                  decoration: BoxDecoration(
                    color: Colors.white
                    ,
                    // border: Border.all(color: Colors.blueAccent),
                    boxShadow: [BoxShadow(offset: Offset(0, 0),blurRadius: 5,spreadRadius: 1,color: Colors.grey)],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.address,
                          style: TextStyle( fontSize: 25),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 350,
                              height: 1,
                              child: ColoredBox(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      final Uri _url = Uri.parse(widget.location);
                                      Future<void> _launchUrl() async {
                                        if (!await launchUrl(_url)) {
                                          throw Exception('Could not launch $_url');
                                        }
                                      }
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Direction()));
                                      _launchUrl();
                                      print('clicked');
                                    },
                                    child: Container(
                                      height: 30,

                                      child: Row(
                                        children: [
                                          Icon(Icons.directions, color: Colors.red),
                                          Text(
                                            "Get Directions",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),),
                                        ],
                                      ),
                                    ),
                                  )
                                ],),)
                          ],
                        ),
                      ]),

                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Rating",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),


                ],
              ),
            ),
        SizedBox(height: 40,),
     Row(mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Column(
             // crossAxisAlignment: CrossAxisAlignment.,
             children: [
               Text(ratingavg.toString(),style:
               TextStyle(fontSize:30, color: Colors.blue[900], fontWeight: FontWeight.w500),),
               SizedBox(height: 10,),

               RatingBar.builder(
                 ignoreGestures: true,
                 initialRating: avg,
                 minRating: 1,
                 direction: Axis.horizontal,
                 allowHalfRating: true,
                 itemCount: 5,
                 itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                 itemBuilder: (context, _) => Icon(
                   Icons.star,
                   color: Colors.amber,
                 ),
                 onRatingUpdate: (rating) {
                   print(rating);
                 },
               ),
               SizedBox(
                 height: 100,
               )
             ],
           )
         ],
     )

          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(20),
          ),
          height: 60,
          width: 450,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(context: context, builder: (BuildContext context){
                return bottomSheet(data: widget.data);
              }
              );

              // showDialog(
              //   context: context,
              //     builder: (BuildContext context) {
              //       double _value2 = 4.0;
              //
              //       return   AlertDialog(
              //        contentPadding: EdgeInsets.zero
              //         ,
              //       content: Container(
              //         height: 300,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //           ),
              //
              //           child: Padding(
              //             padding: const EdgeInsets.all(15.0),
              //             child:
              //
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //
              //
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 5.0),
              //                   child: Container(
              //                     child: Text('select time needed to charge:',
              //                       style: TextStyle(fontWeight:FontWeight.w500, fontSize: 20),),
              //                   ),
              //                 ),
              //                 SizedBox(height: 10,),
              //
              //
              //
              //                 SfSlider(
              //                   min: 0.0,
              //                   max: 100.0,
              //                   value: _value2,
              //                   interval: 20,
              //                   showTicks: true,
              //                   showLabels: true,
              //                   enableTooltip: true,
              //                   minorTicksPerInterval: 1,
              //                   onChanged: (dynamic value){
              //
              //                     _value2 = value;
              //
              //                     setState(() {
              //                       print(_value2);
              //                     });
              //                   },
              //                 ),
              //
              //
              //                 SizedBox(height: 30,),
              //
              //                 Container(
              //                   child:
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text('Apply Coupons',
              //                         style:TextStyle(
              //                           fontSize: 15,
              //                         ),),
              //                       // SizedBox(width: 280,),
              //                       Text('View Coupons',
              //                         style: TextStyle(
              //                           fontSize: 15,
              //                           color: Colors.red,
              //                         ),)
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(height: 10,),
              //                 Container(
              //                   child:
              //                   Text('Estimated Cost:',
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                     ),),
              //                 ),
              //
              //                 SizedBox(height: 40,),
              //
              //                 Container(
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
              //                       children: [
              //                         Text('Wallet Balance:'),
              //
              //                         Container(
              //                           decoration: BoxDecoration(
              //                             color: Colors.blue[900],
              //                             borderRadius: BorderRadius.circular(20),
              //                           ),
              //                           child: Padding(
              //                             padding: const EdgeInsets.all(20.0),
              //                             child: Text("Book",
              //                               style: TextStyle(
              //                                   color: Colors.white
              //                               ),),
              //                           ),
              //                         )
              //                       ],
              //                     )
              //                 ),
              //               ],
              //             ),
              //           )
              //       ),
              //     );
              //     },
              //
              //
              //
              // );
              setState(() {
              });
            },
            child: Text(
              "Charge Now",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class bottomSheet extends StatefulWidget {

  final DocumentSnapshot data;
  const bottomSheet({Key? key, required this.data}) : super(key: key);

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  double estimate=0;
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 5.0,top: 10),
                child: Container(
                  child: Text('select time needed to charge:',
                    style: TextStyle( fontSize: 20),),
                ),
              ),
              SizedBox(height: 10,),

              SfSlider(
                min: 0,
                max: 100,
                value: _value,
                interval: 20,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value){
                  _value = value;

                  setState(() {
                    print(value);



                    print(widget.data['time']);
                    print(value/double.tryParse(widget.data['time']));
                    print('====================');
                    print(widget.data['pricePerUnit']);
                    print(double.tryParse(widget.data['pricePerUnit'])!*(value/double.tryParse(widget.data['time'])));
                    estimate= double.tryParse(widget.data['pricePerUnit'])!*(value/double.tryParse(widget.data['time']));

                  });
                },
              ),

              SizedBox(height: 30,),

              Container(
                child:
                Text('Estimated Cost: '+estimate.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 20,
                  ),),
              ),

              SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add Offer Coupons',
                        style:TextStyle(
                          fontSize: 18,
                        ),),

                      SizedBox(height: 10),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coupons()));
                        },
                        child: Text('View Coupons',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Wallet Balance : '+walletBalance.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 18,
                      ),),

                      InkWell(
                        onTap: (){
                          if(_value!=0&&walletBalance>estimate){
                          FirebaseFirestore.instance.collection('booking').add({
                            'verified':false,
                            'rejected':false,
                            'date':DateTime.now(),
                            'timeNeeded':_value,
                            'estimatePrice':estimate,
                            'userId':currentUserId,
                            'userName':currentUserName,
                            'userImage':currentUserImage,
                            'userEmail':currentUserEmail,
                            'stationId':widget.data['id'],
                            'stationName':widget.data['name'],


                          }).then((value) {
                            value.update({
                              'id':value.id
                            });
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                          else{
                            Navigator.pop(context);
                            _value==0?
                            showUploadMessage(context, 'please select charging time'):
                            showUploadMessage(context, 'insufficient balance');

                          }
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Book",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}
//
// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }
// final Uri _url = Uri.parse('https://goo.gl/maps/Hxyag3uXbaXPiquh6');
