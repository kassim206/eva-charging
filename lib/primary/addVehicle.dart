import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/routing.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({
    Key? key,
  }) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

bool vehicleSelected = false;
int? vehicleSelect ;

List vehicleData=[];

class _AddVehicleState extends State<AddVehicle> with TickerProviderStateMixin {
  TabController? _tabController1;
  @override
  void initState() {
    _tabController1 = TabController(length: 4, vsync: this);
    _tabController1?.addListener(_handleTabSelection);

    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }
  var size,height,width;
  @override
  void dispose() {
    super.dispose();
    _tabController1?.dispose();
  }

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Add Vehicle'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.white,
          height: 1000,
          width: 500,
          margin: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('Choose Brand',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                Container(
                  height: 800,
                  width: 555,
                  color: Colors.white,
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: 7,
                    child: Column(
                      children: [

                        Container(
                          padding: EdgeInsets.only(
                              left: 12, top: 7, right: 12, bottom: 7),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                          ),
                          child: TabBar(
                            isScrollable: true,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                            unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                            // labelColor: Color(0xffCB202D),
                            // isScrollable: true,
                            indicator: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(11)),
                            indicatorWeight: .1,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(child: Container(
                                  width: 100,
                          child: Text('ALL')),),

                              Tab(child: Container(
                                width: 100,
                                  child: Text('TATA'))),

                              Tab(child: Container(
                                  width:100,
                                  child: Text('MG'))),

                              Tab(child: Container(
                                width: 100,
                                  child: Text('HYUNDAI'))),

                              Tab(child: Container(
                                  width:100,
                                  child: Text('BENZ'))),

                              Tab(child: Container(
                                  width:100,
                                  child: Text('2-Wheeler'))),

                              Tab(child: Container(
                                  width:100,
                                  child: Text('3-Wheeler'))),


                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      vehicleData = data;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    vehicleSelect = index;
                                                    print(vehicleSelect);
                                                    vehicleSelected =true;
                                                  });
                                                },
                                                child: Container(
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(13),
                                                      border: Border.all(
                                                          width:vehicleSelect==index ?3:1 ,
                                                          color: vehicleSelect==index ?Colors.indigo: Colors.black54),
                                                         color : Colors.white),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 120,
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(20),
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(data[index]['image']),
                                                                fit: BoxFit.contain)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(data[index]['brand'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),Text(data[index]['model'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );

                                          });
                                    }
                                ),
                              ),
                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle')
                                        .where('brand',isEqualTo: 'TATA').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return
                                              Padding(
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
                                                      height: 120,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20),
                                                            bottomLeft: Radius.circular(20),
                                                          ),
                                                          image: DecorationImage(
                                                              image: NetworkImage(data[index]['image']),
                                                              fit: BoxFit.contain)),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(data[index]['brand']+' '+data[index]['model'],
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            );

                                          });
                                    }
                                ),
                              ),

                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle')
                                        .where('brand',isEqualTo: 'MG').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return
                                              Padding(
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
                                                        height: 120,
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(20),
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(data[index]['image']),
                                                                fit: BoxFit.contain)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(

                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(data[index]['brand']+' '+data[index]['model'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.left,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );

                                          });
                                    }
                                ),
                              ),
                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle')
                                        .where('brand',isEqualTo: 'HYUNDAI').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return
                                              Padding(
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
                                                        height: 120,
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(20),
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(data[index]['image']),
                                                                fit: BoxFit.contain)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(

                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(data[index]['brand']+' '+data[index]['model'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.left,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );

                                          });
                                    }
                                ),
                              ),
                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle')
                                        .where('brand',isEqualTo: 'BENZ').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return
                                              Padding(
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
                                                        height: 120,
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(20),
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(data[index]['image']),
                                                                fit: BoxFit.contain)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(

                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(data[index]['brand']+' '+data[index]['model'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.left,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );

                                          });
                                    }
                                ),
                              ),

                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle')
                                        .where('brand',isEqualTo: 'TWO').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return
                                              Padding(
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
                                                        height: 120,
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(20),
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(data[index]['image']),
                                                                fit: BoxFit.contain)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(

                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(data[index]['brand']+' '+data[index]['model'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.left,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );

                                          });
                                    }
                                ),
                              ),

                              Container(
                                height: 800,
                                width: 500,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('vehicle')
                                        .where('brand',isEqualTo: 'THREE').snapshots(),
                                    builder: (context, snapshot) {
                                      if(!snapshot.hasData){
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data=snapshot.data!.docs;
                                      return data.length==0?Center(child: Text('No Vehicles Found'),):ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,int index){
                                            return
                                              Padding(
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
                                                        height: 120,
                                                        width: 120,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(20),
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(data[index]['image']),
                                                                fit: BoxFit.contain)),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(

                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(data[index]['brand']+' '+data[index]['model'],
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                                textAlign: TextAlign.left,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );

                                          });
                                    }
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
      bottomSheet:                 Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap:vehicleSelected == false?(){}:
                (){
              print(vehicleData[vehicleSelect!]['brand']);

              FirebaseFirestore.instance.collection('users').doc(currentUserId).update(
                  {
                    'vehicles':FieldValue.arrayUnion(
                        [{
                          'brand':vehicleData[vehicleSelect!]['brand'],
                          'model':vehicleData[vehicleSelect!]['model'],
                          'image':vehicleData[vehicleSelect!]['image'],

                        }]
                    )
                  }

              ).then((value) => showUploadMessage(context, 'Vehicle Added'));
              vehicleSelected = false;
              vehicleSelect  = null;
              setState(() {

              });

// FirebaseFirestore.instance.collection(collectionPath)
            },
            child: Container(
              width:width*0.8,
              height: 50,
              decoration: BoxDecoration(
                color: vehicleSelected == false?Colors.grey:Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text("Confirm",
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
