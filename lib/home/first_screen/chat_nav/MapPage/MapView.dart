import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  
  Completer<GoogleMapController> _controller = Completer();
  String _locationAddress = "";
  CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );


  @override
  void initState() {
    Utils().getUserLocation().then((location) async {
      print("location : $location");
      if(location != null){
        _locationAddress = await _decode(location);
        setState(() {
          _initialLocation = CameraPosition(target: LatLng(location.latitude,location.longitude));

        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return new Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialLocation,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 60,left: 25,right: 25),
              padding: const EdgeInsets.all(10),
              width: size.width,
              child: Text(_locationAddress,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                color: MyTheme.mainAppColor,
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
          IconButton(onPressed: () async {
            final GoogleMapController controller = await _controller.future;
            LatLng location = await controller.getLatLng(ScreenCoordinate(x: size.width.toInt(), y: size.height.toInt()));
            print(location);
            setState(() {
              _decode(location).then((value) {
                setState(() {
                  _locationAddress = value;
                });
              });
            });
            //Navigator.pop(context,location);
          }, icon: Icon(Icons.location_on,color: MyTheme.mainAppColor,),iconSize : 60,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  onPressed: _currentLocation,
                  label: Text('موقعك الحالي'),
                  icon: Icon(Icons.location_searching),
                ),
                SizedBox(height: 10,),
                FloatingActionButton.extended(
                  onPressed: (){
                    Navigator.pop(context,GeoPoint(_initialLocation.target.latitude, _initialLocation.target.longitude));
                  },
                  label: Text('تاكيد'),
                ),
                SizedBox(height: 10,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation = await Utils().getUserLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLocation.longitude,currentLocation.longitude),zoom: 14)));
  }
  Future<String> _decode(location) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(location.latitude,location.longitude));
    if(addresses != null ){
      var first = addresses.first;
      return first.addressLine;
    }
    return "مكان غير معروف";
  }
}