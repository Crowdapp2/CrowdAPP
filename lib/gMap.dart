
import 'dart:async';

import 'package:geocoding/geocoding.dart';

import 'login2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart ' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'package:google_maps_flutter/google_maps_flutter.dart';

class gMap extends StatefulWidget {
  final String  name ;
  final  String phone ;
  final String sName ;
  final String area ;
  final String maxC;
  final String char;
  final LatLng Lat;
  final LatLng Long;

  // ignore: sort_constructors_first
  const gMap({Key key, this.name, this.phone, this.sName, this.area, this.maxC, this.char, this.Lat, this.Long}) : super(key: key);
  @override
  _gMap createState() => _gMap();

}
// ignore: camel_case_types
class _gMap extends State<gMap> {
  Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> controller1;
  var Lat ;
  var Long;
  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  static LatLng _initialPosition;
   List<Marker> _markers = [];
  static  LatLng _lastMapPosition = _initialPosition;

  @override
  void initState() {
    super.initState();
    if (widget.Long != null && widget.Long != null){
      Lat = widget.Lat;
      Long = widget.Long;
    }
    else{
      _getUserLocation();

    }

  }
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      Lat = position.latitude;
      Long = position.longitude;
      _markers.add(Marker(
          markerId: MarkerId("M1"),
          position: LatLng(Lat,Long),
          draggable: true,
      )
      );
      print('${placemark[0].name}');
    });}
    changeMarker(LatLng tappedPoint){
      Lat= tappedPoint.latitude;
      Long = tappedPoint.longitude;
    setState(() {
      _markers = [];
      _markers.add(Marker(
        markerId: MarkerId("M1"),
        position: tappedPoint,
      ));
    });
    }
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }



  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future insertData( ) async {
    var maxCu= (double.parse(widget.area)*(1-0.30)~/4).toInt();

    var query = " INSERT INTO Users (UserName, Role,Gender,phoneNum) VALUES('${ widget.name})', 'Admin','${ widget.char}','${ widget.phone}'); INSERT INTO Supermarkets (Name,longitude,Latitude, Max_user,Area) VALUES('${ widget.sName}','${Lat}','${Long}', '${maxCu}','${ widget.area}');";


    final response = await http.post(Uri.parse("https://10.0.2.2/indata.php"), body: {
      'query':query
    });
    print(response.statusCode);
    print(response.body);
  }



  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xffffffff),

      appBar: AppBar(


        title: const Text('Locate the supermarket', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),),
        centerTitle: true,),
      body: Stack(
          children: <Widget>[



              Container(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:  _initialPosition,
                    zoom: 15,


                  ),
                  markers: Set.from(_markers),
                  onMapCreated: _onMapCreated,
                  onTap: changeMarker,


                ),),
            Container(
              alignment: Alignment.bottomCenter,
              padding: new EdgeInsets.fromLTRB(0,0, 0,25 ),
              child: MaterialButton(
                  minWidth: 320,
                  height: 45,
                  onPressed: () {
                    insertData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login2()),
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