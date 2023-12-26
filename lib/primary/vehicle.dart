import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/routing.dart';
import 'package:untitled1/primary/addVehicle.dart';
class Vehicle extends StatefulWidget {
  const Vehicle({Key? key}) : super(key: key);

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text('Manage Vehicle'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
            child: Text('Your Vehicles',
              style: TextStyle(
              fontSize: 18,
            ),),

            ),

          Expanded(
            flex: 0,
            child: Padding(

                padding: const EdgeInsets.all(20),
              child: Container(
               width: 450,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),


                ),

                child: StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('users').snapshots() ,
                  builder: ( context,  snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data?.docs;
                    List vehicleData = data?[0]['vehicles'];

                    print(vehicleData);
                    print(vehicleData.length);


                    // data?[0]['vehicles'][index]['image']
                      return ListView.builder(
                        shrinkWrap: true,
                          itemCount: vehicleData.length,
                          itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(color: vehicleSelect==index ?Colors.indigo: Colors.black54),
                                // border: Border.all(color: Colors.indigo),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(data?[0]['vehicles'][index]['image']),
                                          fit: BoxFit.contain)),
                                ),

                                Container(

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data?[0]['vehicles'][index]['brand'],
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),Text(
                                        data?[0]['vehicles'][index]['model'],
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),

                                InkWell(
                                  onTap: (){
                                    List Vdata = vehicleData;
                                    print(Vdata);

                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: const Text('Delete vehicle?'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              // Text('This is a demo alert dialog.'),
                                              Text('Would you like to remove this vehicle from your saved vehicles?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[

                                          TextButton(
                                            child: const Text('keep',style: TextStyle(
                                              color: Colors.blue
                                            ),),
                                            onPressed: () {
                                              // print();

                                              Navigator.of(context).pop();
                                            },
                                          ),

                                          TextButton(
                                            child: const Text('Remove',style: TextStyle(
                                                color: Colors.red
                                            ),),
                                            onPressed: () {


                                             try{
                                               FirebaseFirestore.instance.collection('users').doc(currentUserId).update(
                                                   {
                                                     'vehicles':FieldValue.arrayRemove(
                                                         [vehicleData[index]]
                                                     )
                                                   }
                                               );
                                             }
                                             catch(e){
                                               print(e);
                                             }
                                              Navigator.pop(context);
                                            },
                                          ),

                                        ],
                                      );
                                    });
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Confirm"),
                                      content: Text("Do you want to delete?"),
                                      actions: [
                                    ElevatedButton(
                                    child: Text('Button'),
                                        onPressed: () {},),
                                      ],
                                    );
                                  },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.delete,color: Colors.red,),
                                    )),

                              ],
                            ),
                          ),
                        );
                      }


                    );
                  },
                ),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:18, left: 18),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddVehicle()));
             },

              child: Text('Add a new vehicle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                  fontSize: 18,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
