// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled1/auth/login.dart';
// //import 'package:untitled1/login.dart';
// import 'package:untitled1/auth/register.dart';
//
// import '../auth/routing.dart';
// import '../bottombar/navigationBar.dart';
//
//
// class Open extends StatefulWidget {
//   const Open({Key? key}) : super(key: key);
//
//   @override
//   State<Open> createState() => _OpenState();
// }
//
// class _OpenState extends State<Open> {
//   late SharedPreferences localStorage;
//
//   Future getValidationData() async{
//
//
//     localStorage = await SharedPreferences.getInstance();
//
//     // localStorage.remove('email');
//     var us =localStorage.getString('email').toString();
//     var id =localStorage.getString('id').toString();
//
//
//     setState(() {
//       currentUserEmail = us;
//       currentUserId = id;
//
//     });
//     print(currentUserId);
//     print(currentUserEmail);
//
//
//
//   }
//   @override
//   void initState() {
//     // Timer(Duration(seconds: 1), () {
//     //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OnBoarding(),), (route) => false);
//     //
//     // });
//     getValidationData().whenComplete(() async{
//
//
//       Timer(Duration(seconds: 2),() {
//
//         FirebaseAuth.instance
//             .userChanges()
//             .listen((User? user) {
//           if (user == null) {
//             if((currentUserId!=null||currentUserId!='null')&&user != null){
//               print('1:1');
//               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Navigation(index:0),), (route) => false);
//
//
//             }else{
//               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);
//
//               print('1:2');
//
//             }
//           } else {
//             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Navigation(index:0),), (route) => false);
//
//             print('User is signed in!');
//           }
//         });
//
//
//         setState((){});
//
//
//
//       }
//
//       );
//
//     } );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade900,
//       body: const Center(
//           child: Text("eva",
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 65,
//                 fontFamily: "JosefinSans"),)
//       ),
//     );
//   }
// }