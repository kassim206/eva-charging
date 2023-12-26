import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/auth/routing.dart';
import 'package:untitled1/bottombar/navigationBar.dart';
import 'package:untitled1/primary/editAccount.dart';
import 'package:untitled1/primary/vehicle.dart';
import '../auth/login.dart';
import '../primary/myBookings.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Account'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[200],
              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          currentUserImage==''||currentUserImage==null?
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8, top: 8,bottom: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/profile.png')
                            ),
                          )
                          :Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8, top: 8,bottom: 8),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: CachedNetworkImageProvider(currentUserImage)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text (
                                  currentUserName,
                                  style: TextStyle(
                                      fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: Text(
                                    currentUserEmail,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Text(currentUserPhone,
                                style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit(
                                email: currentUserEmail,
                                phone: currentUserPhone,
                                name: currentUserName,
                              )));
                            },
                            child: Container(
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Text("Edit",
                                    style: TextStyle(
                                        color:Colors.white
                                    ),)
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),

              ),
          ),
          SizedBox(height: 5,),

          Container(
            // height: 65,
            width: 460,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                    children: [
                      Text('Wallet Balance: ',style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),),
                      Text(walletBalance.toStringAsFixed(2),style: TextStyle(
                        fontSize: 30,
                      fontWeight: FontWeight.w500),)
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                // SizedBox(width: 230,),
                InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation(index: 1,)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ADD CREDITS',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                ),
              ],
            ),

          ),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Vehicle()));

              },

              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.garage),
                        SizedBox(width: 10,),
                        Text(
                          "My Vehicles",style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookings()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bolt_outlined),
                        SizedBox(width: 10,),
                        Text(
                          "My Bookings",style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
          ),

          Divider(thickness: 1),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap:() async {
                    await FirebaseAuth.instance.signOut();
                    final SharedPreferences local = await SharedPreferences.getInstance();
                    local.remove('id');
                    currentUserImage='';
                    currentUserName='';
                    currentUserEmail='';
                    currentUserPhone='';
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                  },
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFB10D0D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(color: Colors.white
                              ,fontSize: 15,
                              fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ), //login
        ],
      ),
    );
  }
}