import 'dart:async';
import 'package:firebase/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class UsersScreen extends StatefulWidget {

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(31.759817, 35.205569),
      zoom: 9.2
  );

  GoogleMapController? _googleMapController;
  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController!.dispose();
    super.dispose();
  }

  Marker? _origin;
  Marker? _destination;


  @override
  Widget build(BuildContext context) {
    return defaultMap();
  }
  Widget defaultMap()=>
      Scaffold(
        body: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (controller)=> _googleMapController = controller,
          markers: {
            if(_origin != null) _origin!,
            if(_destination != null) _destination!,
          },
          onLongPress: _addMarker,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(IconBroken.Location),
          onPressed: ()=> _googleMapController!.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition)
          ) ,
        ),
      );

  void _addMarker(LatLng position){
    if(_origin == null || (_origin != null && _destination != null)){
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: position,
        );
        _destination = null;
      });
    }else{
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: position,
        );
      });
    }
  }
}
