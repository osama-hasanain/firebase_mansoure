import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

const LatLng SOURCE_LOCATION = LatLng(31.515125, 34.452008);
const LatLng DEST_LOCATION = LatLng(31.515750, 34.447742);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class UsersScreen2 extends StatefulWidget {
  @override
  _UsersScreen2State createState() => _UsersScreen2State();
}

class _UsersScreen2State extends State<UsersScreen2> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set<Marker>();

  LatLng? currentLocation;
  LatLng? destinationLocation;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    //initial current location
    setInitialLocation();
  }

  void setInitialLocation(){
    currentLocation = LatLng(
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude,
    );
    destinationLocation = LatLng(
      DEST_LOCATION.latitude,
      DEST_LOCATION.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION
    );

    return Scaffold(
      body: Container(
        child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: false,
          tiltGesturesEnabled: false,
          markers: markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            showPinsOnMap();
            setPolyLines();
          },
        ),
      ),
    );
  }

  void showPinsOnMap(){
    setState(() {
      markers.add(
          Marker(
            position: currentLocation!,
            markerId: MarkerId('sourcePin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          )
      );
      markers.add(
          Marker(
            position: destinationLocation!,
            markerId: MarkerId('destinationPin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          )
      );
    });
  }

  void setPolyLines()async{
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
        'AIzaSyAXKLuKQ-mIpCwiXo5xk-cXTEB-_Ucuk8g',
        PointLatLng(
          currentLocation!.latitude,
          currentLocation!.longitude
        ),
      PointLatLng(
          destinationLocation!.latitude,
          destinationLocation!.longitude
      ),
    );
    if(result.status == 'OK'){
      result.points.forEach((element) {
        polylineCoordinates.add(LatLng(element.latitude,element.longitude));
      });
      setState(() {
        _polylines.add(
          Polyline(
            width: 10,
            polylineId: PolylineId('polyline'),
            color:Color(0xFF08A5CB),
            points: polylineCoordinates
          )
        );
      });
    }
  }
}
