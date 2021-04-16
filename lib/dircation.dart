
import 'dart:async';

import 'package:crwordapp/Selectsupermarket.dart';
import 'package:geocoding/geocoding.dart';

import 'login1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart ' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'package:google_maps_flutter/google_maps_flutter.dart';

class dircation extends StatefulWidget {

  @override
  _dircation createState() => _dircation();

}
// ignore: camel_case_types
class _dircation extends State<dircation> {
  Completer<GoogleMapController> controller1;
  var Lat ;
  var Long;
  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static  LatLng _lastMapPosition = _initialPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      Lat = position.latitude;
      Long = position.longitude;
      print('${placemark[0].name}');
    });}
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }
  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }



  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xffffffff),

      appBar: AppBar(


        title: const Text('dircation to the supermarket', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),),
        centerTitle: true,),
      body: Stack(
          children: <Widget>[



              Container(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target:  _initialPosition,
                    zoom: 15,

                  ),
                ),),
            Container(
              alignment: Alignment.bottomCenter,
              padding: new EdgeInsets.fromLTRB(0,0, 0,25 ),
              child: MaterialButton(
                  minWidth: 320,
                  height: 45,
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => Selectsupermarket()),
                    );
                  },
                  color: const Color(0xffde445f),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)
                  ),
                  child: Text(
                    "DONE",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )

              ),
            ),

          ]),);
  }

}