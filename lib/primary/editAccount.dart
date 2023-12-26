import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/auth/routing.dart';

class Edit extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  Edit({Key? key, required this.name, required this.email, required this.phone, }) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
  }


  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  String imageurl='';
  getimage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
      currentUserImage=url;
    });
    print(url);
    print('==============================');

    if(mounted){
      setState(() {

        image=File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Edit User Info'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
                onTap: () {

                  
                },
                child: Stack(
                  children: [
                    currentUserImage==''||currentUserImage==null?
                     Positioned(
                      child:  CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                        radius: 60,
                        backgroundImage:
                        AssetImage('assets/images/profile.png')
                      ),
                    )
                    : Positioned(
                  child:  CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 60,
                      backgroundImage:
                      CachedNetworkImageProvider(currentUserImage)
                  ),
                ),
                    Positioned(
                      top: 80,
                        left: 85,
                        child: InkWell(
                          onTap: (){
                             getimage();
                          },
                          child: Container(
                            height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Icon(Icons.edit,color: Colors.white,)),
                        ))
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            if(emailController?.text!=''&& nameController?.text!=''
                &&phoneController?.text!=''){
              print('   kkkk');

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUserId)
                  .update({
                'email': emailController!.text,
                'display_name': nameController!.text,
                'phoneNo': phoneController!.text,
                'photo_url':currentUserImage
              });

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('profile updated'),
              ));

              Navigator.pop(context);
            }
            else{
              currentUserImage==''?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('please select image '),))
                  :nameController?.text==''?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('please enter your name'),))
                  :  emailController?.text==''?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('please enter your email'),))
                  :ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('please enter your mobile number'),));
            }
          },
          child: Container(
            height: 60,
            width: 450,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
