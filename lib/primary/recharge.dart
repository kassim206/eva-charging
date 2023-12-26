import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/auth/routing.dart';


class Recharge extends StatefulWidget {
  const Recharge({Key? key}) : super(key: key);

  @override
  State<Recharge> createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {

  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  String imageurl='';
  getimage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    showUploadMessage(context, 'uploading...',showLoading: true);
    image=File(image!.path);

    DocumentSnapshot id = await FirebaseFirestore
        .instance
        .collection('settings')
        .doc("settings")
        .get();
    id.reference.update(
        {"images": FieldValue.increment(1)});
    var imageId = id['images'];

    var reference = await storage.ref().child("profileImages/$imageId").putFile(image!);

    var url = await reference.ref.getDownloadURL();
    setState(() {
      imageurl=url;
      showUploadMessage(context, 'image uploaded succcessfully');
    });
    print(url);
    print('==============================');

    if(mounted){
      setState(() {

        image=File(image!.path);
      });
    }
  }

  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Add Credits'),
        centerTitle: true
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500, width: 500,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 8),
                    child: Text(
                      'Balance:', style: TextStyle(
                        color: Colors.black,
                      fontSize: 20,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 2,bottom: 15),
                    child: Text(walletBalance.toStringAsFixed(2), style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w600
                    ),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 8),
                    child: Text(
                      'Enter Amount', style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: amount,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        getimage();
                      },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                                'Upload Screenshot', style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                    ),

                  imageurl==''?Container(): Container(
                     height: 100,
                     width: 100,
                     decoration: BoxDecoration(

                       image: DecorationImage(
                         image: NetworkImage(imageurl)
                       )
                     )
                   ),


               SizedBox(height: 20,),


                  Center(
                    child: InkWell(
                      onTap:(){
                        if(amount.text!= ""&&imageurl!=''){
                          print(amount.text);
                          FirebaseFirestore.instance.collection('amount').add({
                            'userId':currentUserId,
                            'userName':currentUserName,
                            'email':currentUserEmail,
                            'amount': double.tryParse(amount.text),
                            'image': imageurl,
                            'date':DateTime.now(),
                            'verified':false,
                            'rejected':false
                          }).then((value) {
                            value.update({
                              'rechargeId':value.id
                            });
                          });
                          Navigator.pop(context);
                          setState(() {

                          });

                        }else{
                            amount.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('enter Amount'),
                                )
                            ):ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Upload image'),
                                )
                            );
                        }

                      },
                      child: Container(
                          width: 450,height: 40,
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[900],
                          ),
                          child:
                          Center(
                            child: Text(
                              'Update', style: TextStyle(
                              color: Colors.white,
                            ),
                            ),
                          )
                      ),
                    ),
                   ),

                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
