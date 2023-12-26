import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/bottombar/navigationBar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passVisibiliy= true;
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final passWord = TextEditingController();
  final cPassWord = TextEditingController();
  List emails=[];

  Future getEmails() async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('User')
        .get();
    for (DocumentSnapshot doc in data.docs) {
      emails.add(doc.get('email'));
      if (mounted) {
        setState(() {

        });
      }
    }

  }
  @override
  void initState() {
    getEmails();    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left:120,right: 120,top: 120),
                          child: Text(
                            'Welcome!',
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 90),
                        child: Text(
                          'Enter your details to register',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextField(
                          controller: fullName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          controller: passWord,
                          obscureText: passVisibiliy,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                passVisibiliy = !passVisibiliy;
                              });
                            }, icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passVisibiliy
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),),
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          controller: cPassWord,
                          obscureText: passVisibiliy,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                passVisibiliy = !passVisibiliy;
                              });
                            }, icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passVisibiliy
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),),

                            border: const OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30,left: 120,right: 120),
                        child: Container(
                          height: 50,
                          child: InkWell(
                            onTap: () async {
                              if(fullName.text!='' && phoneNumber.text!='' &&
                                  email.text!='' && passWord.text!='' && cPassWord.text!='' &&
                                  passWord.text.length<=8 && (cPassWord.text==passWord.text))
                              {
                                if (emails.contains(email?.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('user already exist!.'),
                                      )
                                  ) ;                                     }
                                else {
                                  final SharedPreferences local=await SharedPreferences.getInstance();

                                  String id='';
                                  FirebaseFirestore.instance.collection('users').add({
                                    'userName':email.text,
                                    'display_name':fullName?.text,
                                    'created_time':DateTime.now(),
                                    'email':email.text,
                                    'photo_url':'',
                                    'phoneNo':phoneNumber?.text,
                                    'password':passWord?.text,
                                    'wallet':0.0,
                                    'vehicles':[]

                                  }).then((value) async {
                                    value.update({
                                      'uid':value.id
                                    });
                                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(),
                                        password: passWord.text.trim()).then((value) =>FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set({
                                      'name':fullName.text,
                                      'phone':phoneNumber.text,
                                      'email':email.text,
                                      'password':passWord.text
                                    }));

                                    if(mounted){
                                      setState((){});
                                    }
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Navigation(index: 0,)), (route) => false);
                                  });


                                }

                                // FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(),
                                //     password: passWord.text.trim()).then((value) =>FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set({
                                //   'name':fullName.text,
                                //   'phone':phoneNumber.text,
                                //   'email':email.text,
                                //   'password':passWord.text
                                // }));
                                //
                                // FirebaseFirestore.instance.collection('user').add({
                                //   'name':fullName.text,
                                //   'phone':phoneNumber.text,
                                //   'email':email.text,
                                //   'password':passWord.text
                                // });

                                fullName.clear();
                                phoneNumber.clear();
                                email.clear();
                                passWord.clear();
                                cPassWord.clear();

                              }
                              else{
                                fullName.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter your full name'),
                                    )
                                ):
                                phoneNumber.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter your phonenumber'),
                                    )
                                ):
                                email.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter your email'),
                                    )
                                ):
                                passWord.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter password'),
                                    )
                                ):
                                cPassWord.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter confirm password'),
                                    )
                                ):
                                passWord.text.length<=8?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('password too short!'),
                                    )
                                ):
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('entered wrong password'),
                                    )
                                );
                              }
                            },

                            child: Container(
                              decoration: BoxDecoration( color: Colors.blue.shade900,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.all(Radius.circular(8)) ),
                              child: const Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white,fontSize: 17,) ,)),),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
