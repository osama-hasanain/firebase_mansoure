import 'dart:async';
import 'package:firebase/modual/users/user_screen2.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

import 'live_location_map.dart';

class LiveLocation extends StatefulWidget {

  @override
  _LiveLocationState createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: _getLocation, child: Text('add my location')),
          TextButton(onPressed: _listenLocation, child: Text('enable live location')),
          TextButton(onPressed: _stopLocation, child: Text('stop live location')),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(),);
                return LiveLocationMap(snapshot.data!.docs[0].id);
                // return ListView.builder(
                //   itemCount: snapshot.data!.size,
                //   itemBuilder: (context,index){
                //     return ListTile(
                //       title: Text(snapshot.data!.docs[index]['name'].toString()),
                //       subtitle: Row(
                //         children: [
                //           Text(snapshot.data!.docs[index]['latitude'].toString()),
                //           SizedBox(width: 20,),
                //           Text(snapshot.data!.docs[index]['longitude'].toString())
                //         ],
                //       ),
                //       trailing: IconButton(
                //         icon: Icon(Icons.directions),
                //         onPressed: (){
                //           Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context)=>
                //                 LiveLocationMap(snapshot.data!.docs[index].id),)
                //           );
                //         },
                //       ),
                //     );
                //   },
                // );
              },
            ),
          )
        ],
      ),
    );
  }
  _getLocation() async {
    try{
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name':'Osama'
      },SetOptions(merge: true));
    }catch(e){
      print(e);
    }
  }

  _listenLocation() async {
    _locationSubscription = location.onLocationChanged.
    handleError((onError){
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).
    listen((loc.LocationData currentLocation)async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
        'name':'Osama'
      },SetOptions(merge: true));
    });
  }
  _stopLocation(){
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async{
    var stauts = await Permission.location.request();
    if(stauts.isGranted)
      print('done');
    else if(stauts.isDenied)
      _requestPermission();
    else if(stauts.isPermanentlyDenied)
      openAppSettings();
  }
}