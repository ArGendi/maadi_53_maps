// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController controller;
  bool normal = true;
  Set<Marker> myMarkers = {};
  Set<Polyline> myPolylines = {};

  void getPermission() async{
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("a3mlk eh ??"))
        );
      }
      else{
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          onTap: (p) async{
            Marker newMarker = Marker(
              markerId: MarkerId("destination"), 
              position: p,
            );
            Position myPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            Polyline newPolyline = Polyline(
              polylineId: PolylineId("my route"),
              width: 3,
              color: Colors.red,
              points: [
                LatLng(myPosition.latitude, myPosition.longitude),
                LatLng(p.latitude, p.longitude)
              ]
            );
            setState(() {
              myMarkers.add(newMarker);
              myPolylines.add(newPolyline);
            });
          },
          markers: myMarkers,
          polylines: myPolylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: normal == true ? MapType.normal : MapType.satellite,
          onMapCreated: (mapController) async{
            controller = mapController;
            Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(position.latitude, position.longitude) , zoom: 12),
              )
            );
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(38.42796133580664, -121.085749655962),
            zoom: 14.5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            normal = !normal;
          });
        },
        child: Icon(Icons.swap_horiz_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}