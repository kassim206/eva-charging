import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/auth/login.dart';
import '../bottombar/navigationBar.dart';
import '../primary/open.dart';


var userData;
var currentUserName ;
var currentUserImage ;
var currentUserEmail ;
var currentUserPhone ;
var currentUserId;
var walletBalance;
var w;
List usersId=[];


void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}

class Routing extends StatefulWidget {
  const Routing({Key? key}) : super(key: key);

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {

  getData() async {
    final SharedPreferences local = await SharedPreferences.getInstance();
    currentUserId=local.getString('id');
    print(currentUserId);
    print('//////////////////////////////////////////////////////////////');
    setState(() {

    });
  }
  @override

  void initState() {
    getData();
    Timer(Duration(seconds: 2), () {
      if(currentUserId==null||currentUserId==''){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
      }
      else{
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navigation(index: 0)));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Navigation(index: 0,)), (route) => false);

      }
    });
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    w=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.blue.shade900,
      body:  const Center(
          child: Text("eva",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 65,
                fontFamily: "JosefinSans"),)
      ),
    );
  }
}