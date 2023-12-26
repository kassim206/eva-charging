import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/auth/register.dart';
import 'package:untitled1/auth/routing.dart';

import '../bottombar/navigationBar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  TextEditingController userName = TextEditingController(text: 'mohammedalfaz0341@gmail.com');
  TextEditingController passWord = TextEditingController(text: '12345678');

  getUser() async {
    QuerySnapshot snap=await FirebaseFirestore.instance.collection('users')
        .where('userName',isEqualTo:userName!.text )
        .where('password',isEqualTo:  passWord!.text)
        .get();

    if(snap.docs.isNotEmpty) {
      final SharedPreferences local = await SharedPreferences.getInstance();
      local.setString('id', snap.docs[0].id);
      local.setString('email', userName.text);
      print(local.getString('id'));
      print('pppppppppp');
      currentUserId = snap.docs[0].id;
      print(currentUserId);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Navigation(index: 0,)), (
              route) => false);
    }else{
       showUploadMessage(context, 'No Users Found...');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),//W
                SizedBox(height: 25,),
// elcome Back
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      child: Text(
                        "Please Login to continue",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),//please login to continue
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top:20, right: 20),
                  child: TextField(
                    controller: userName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: _passwordVisible,
                    controller: passWord,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 50,),

                Container(
                  height: 50,
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      if (userName.text != "" &&
                          passWord.text != "" &&
                          passWord.text.length >= 8) {
                        print(userName.text);
                        print(passWord.text);

                        getUser();
                      } else {
                        userName.text == ""
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text('enter username'),
                              ))
                            : passWord.text == ""
                                ? ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text('enter password'),
                                  ))
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text('password is too short'),
                                  ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          border: Border.all(),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" Don't have an account? ", style: TextStyle(
                        fontSize: 20
                    )),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                        child: Text("Sign up", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]
                        ),)),

                  ],
                ),

              ],
            )));
  }
}
