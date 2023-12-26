import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/routing.dart';
import 'package:untitled1/bottombar/profilePage.dart';
import 'package:untitled1/bottombar/walletPage.dart';
import 'homePage.dart';

class Navigation extends StatefulWidget {
  final int index;
  const Navigation({Key?
  key, required this.index}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();

}

class _NavigationState extends State<Navigation> {
  int selectedIndex=0;

  getUserDetails(){
    FirebaseFirestore.instance
        .collection('users')
        .where('uid',isEqualTo: currentUserId)
        .snapshots()
        .listen((event) {
      for(DocumentSnapshot doc in event.docs){
        currentUserName=doc.get('display_name');
         currentUserImage=doc.get('photo_url') ;
         currentUserEmail =doc.get('email');
         currentUserPhone =doc.get('phoneNo');
         walletBalance =doc.get('wallet');
      }
      if(mounted){
        setState(() {

        });
      }

      print(currentUserName);
      print(currentUserEmail);
      print(currentUserPhone);
      print('----------------------------------------------------');
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    getUserDetails();
      selectedIndex=widget.index;
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      Home(),
      Wallet(),
      // Saved(),
      Profile(),
    ];

    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue.shade600,

        onTap: _onItemTapped,
        items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',),

          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.bookmark),
          //   label: 'Saved',),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',),
        ],)
    );
  }
}
