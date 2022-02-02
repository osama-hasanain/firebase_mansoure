import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LiveLocationMap extends StatefulWidget {
  final String user_id;
  LiveLocationMap(this.user_id);
  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
  final loc.Location location= loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(_added) {
            myMap(snapshot);
            setPolyLines(snapshot);
          }
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          return GoogleMap(
            mapType: MapType.normal,
            markers: {Marker(
                markerId: MarkerId('id'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                position: LatLng(
                  snapshot.data!.docs.singleWhere(
                          (element) =>element.id == widget.user_id)['latitude'],
                  snapshot.data!.docs.singleWhere(
                          (element) =>element.id == widget.user_id)['longitude'],
                )
            )},
            initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data!.docs.singleWhere(
                        (element) =>element.id == widget.user_id)['latitude'],
                snapshot.data!.docs.singleWhere(
                        (element) =>element.id == widget.user_id)['longitude'],
              ),
               zoom: 20,
              bearing: 30,
              tilt: 80
            ),
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller)async{
              setState(() {
                _controller = controller;
                _added = true;
              });
          },
          );
        },
      ),
    );
  }
  Future<void> myMap(AsyncSnapshot<QuerySnapshot> snapshot)async{
    await _controller
        .animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(snapshot.data!.docs.
            singleWhere((element) => element.id == widget.user_id)['latitude'],
            snapshot.data!.docs.
            singleWhere((element) => element.id == widget.user_id)['longitude'],
            ),
             zoom: 20,
             bearing: 30,
             tilt: 80
          ),)
        );
    ;
  }
  void setPolyLines(AsyncSnapshot<QuerySnapshot> snapshot)async{
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      'AIzaSyAXKLuKQ-mIpCwiXo5xk-cXTEB-_Ucuk8g',
      PointLatLng(
          snapshot.data!.docs.
          singleWhere((element) => element.id == widget.user_id)['latitude'],
          snapshot.data!.docs.
          singleWhere((element) => element.id == widget.user_id)['longitude']
      ),
      PointLatLng(
          snapshot.data!.docs.
          singleWhere((element) => element.id == widget.user_id)['latitude'],
          snapshot.data!.docs.
          singleWhere((element) => element.id == widget.user_id)['longitude']
      ),
    );
    if(result.status == 'OK'){
      result.points.forEach((element) {
        polylineCoordinates.add(LatLng(element.latitude,element.longitude));
      });
      setState(() {
        _polylines.add(
            Polyline(
                width: 5,
                polylineId: PolylineId('polyline'),
                color:Color(0xFF08A5CB),
                points: polylineCoordinates
            )
        );
      });
    }else{
      print(result.errorMessage);
    }
  }
}
