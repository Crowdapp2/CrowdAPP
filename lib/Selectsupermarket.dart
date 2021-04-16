import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'PASSCODE.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './AdminHome.dart';
import 'package:adobe_xd/page_link.dart';
import './Menu.dart';
import 'package:http/http.dart' as http;
import 'dircation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'timeconvert.dart' as timeconvert;

class Selectsupermarket extends StatefulWidget {
  final TextEditingController numOfItemsC;
  final String uid;

  const Selectsupermarket({Key key, this.numOfItemsC, this.uid})
      : super(key: key);

  @override
  SelectsupermarketS createState() => SelectsupermarketS();
}

class SelectsupermarketS extends State<Selectsupermarket> {
  var m = NumberFormat("00", "en_US");
  var h = NumberFormat("00", "en_US");
  var d = NumberFormat("00.0", "en_US");
  var ULat, ULong;
  var Crowd;

  List<dynamic> supermarkets = [];
  var size;

  Future<List> getData() async {
    var query =
        " SELECT COUNT(TR_ID) AS 'ActiveUser' , Active.S_ID ,Supermarkets.Name,Supermarkets.S_ID, Supermarkets.Area, Supermarkets.longitude , Supermarkets.Latitude , Supermarkets.Max_user FROM Active LEFT JOIN Supermarkets on Active.S_ID= Supermarkets.S_ID  GROUP BY Active.S_ID;";

    final response = await http
        .post(Uri.parse("http://172.20.10.4/getData.php"), body: {'query': query});
    print(response.statusCode);
    if (response.statusCode == 200) {
      supermarkets = jsonDecode(response.body);
      print(supermarkets);
    }
    size = supermarkets.length;
    print(supermarkets);
    return supermarkets;
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      ULat = position.latitude;
      ULong = position.longitude;
    });
  }

  Future<List> getSuper;

  int hours;
  int minutes;
  int _hours;
  int _minutes;
  double marketArea = 0;
  void timeNeeded(var marketArea) {
    var time;
    int maxCustomer = (marketArea) * (1 - 0.30) ~/ 4;
    int nOI = int.parse(widget.numOfItemsC.text);

    if ((marketArea >= 24) & (marketArea < 100)) {
      time = (nOI * 0.75).toInt();
      double hour = time / 60;
      hours = hour.toInt();
      minutes = time % 60;
      print(hours);
      print(minutes);
    } else if ((marketArea >= 100) & (marketArea < 500)) {
      time = nOI * 1;
      double hour = time / 60;
      hours = hour.toInt();
      minutes = time % 60;
      print(hours);
      print(minutes);
    } else if (marketArea >= 500) {
      time = (nOI * 1.5).toInt();
      double hour = time / 60;
      hours = hour.toInt();
      minutes = time % 60;
      print(hours);
      print(minutes);
    }
  }

  var Lat;
  var Long;
  getCor() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      Lat = position.latitude;
      Long = position.longitude;
    });
  }

  @override
  void initState() {
    getCor();
    _getUserLocation();
    super.initState();
    getSuper = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          title: const Text(
            'Select',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 35,
              )),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
                margin: const EdgeInsets.all(16),
                child: Column(children: <Widget>[
                  FutureBuilder(
                      future: getSuper,
                      // ignore: missing_return
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        var lev;
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            if (int.parse(snapshot.data[index]['ActiveUser']) <
                                int.parse(snapshot.data[index]['Max_user'])) {
                              lev = (int.parse(
                                          snapshot.data[index]['ActiveUser']) /
                                      int.parse(
                                          snapshot.data[index]['Max_user'])) *
                                  100;
                            }

                            if (lev > 75) {
                              return Container(
                                alignment: Alignment.center,
                                // padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.0),
                                    color: const Color(0xffde445f)),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                              );
                            }
                            if (75 < lev && lev < 100) {
                              return Container(
                                alignment: Alignment.center,
                                // padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0.0),
                                  color: Colors.amber,
                                ),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                              );
                            }
                            if (75 > lev) {
                              return Container(
                                alignment: Alignment.center,
                                // padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0.0),
                                  color: const Color(0xff4db8ac),
                                ),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                              );
                            }
                        }
                      }),
                  Transform.translate(
                      offset: Offset(-70, 75),
                      child: FutureBuilder(
                          future: getSuper,
                          // ignore: missing_return
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            var lev;
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              case ConnectionState.done:
                                if (int.parse(
                                        snapshot.data[index]['ActiveUser']) <
                                    int.parse(
                                        snapshot.data[index]['Max_user'])) {
                                  lev = (int.parse(snapshot.data[index]
                                              ['ActiveUser']) /
                                          int.parse(snapshot.data[index]
                                              ['Max_user'])) *
                                      100;
                                  return Text(
                                    'Crowd Level ${m.format(lev)} %',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 23,
                                      color: const Color(0xff4db8ac),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                }
                            }
                          })),
                  Transform.translate(
                      offset: Offset(130, 50),
                      child: FutureBuilder(
                          future: getSuper,
                          // ignore: missing_return
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              case ConnectionState.done:
                                timeNeeded(
                                    double.parse(snapshot.data[index]['Area']));
                                return Text(
                                  '${h.format(hours)}:${m.format(minutes)}',
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 23,
                                    color: const Color(0xff4db8ac),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                );
                            }
                          })),
                  Transform.translate(
                    offset: Offset(-0, -20),
                    child: FutureBuilder(
                        future: getSuper,
                        // ignore: missing_return
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            case ConnectionState.done:
                              return Text(
                                '${snapshot.data[index]['Name']}',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 25,
                                  color: const Color(0xffde445f),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              );
                          }
                        }),
                  ),
                  Transform.translate(
                    offset: Offset(110.0, 30.0),
                    child: FutureBuilder(
                        future: getSuper,
                        // ignore: missing_return
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            case ConnectionState.done:
                              return Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: MaterialButton(
                                    minWidth: 127,
                                    onPressed: () async {
                                      timeNeeded(
                                          double.parse(snapshot.data[index]['Area']));
                                      var now = new DateTime.now();
                                      var nDate = new DateTime.now();
                                      var nDatee = DateFormat('yyyy-MM-dd').format(nDate);
                                      var endDate = now.add(Duration(
                                          hours: hours, minutes: minutes));
                                      String formattedStratTime =
                                          DateFormat('hh:mm:ss').format(now);
                                      String formattedEndTime =
                                          DateFormat('hh:mm:ss')
                                              .format(endDate);
                                      var lev;
                                      if (int.parse(snapshot.data[index]
                                              ['ActiveUser']) <
                                          int.parse(snapshot.data[index]
                                              ['Max_user'])) {
                                        lev = (int.parse(snapshot.data[index]
                                                    ['ActiveUser']) /
                                                int.parse(snapshot.data[index]
                                                    ['Max_user'])) *
                                            100;
                                      }
                                      Crowd=lev;

                                      print(
                                          "$nDatee     $formattedStratTime   $formattedEndTime   $ULat  $ULong  '${snapshot.data[index]['S_ID']}  ${widget.uid}");
                                      var query =
                                          "INSERT INTO Trip (Date,Start_at,End_at, longitude, Latitude, S_ID, U_ID) VALUES( $nDatee,'${formattedStratTime}','${formattedEndTime}', '${ULong}', '${ULat}','${snapshot.data[index]['S_ID']}','${widget.uid}');";
                                      final response = await http.post(
                                          Uri.parse(
                                              "http://172.20.10.4/indata.php"),
                                          body: {'query': query});
                                      print(response.statusCode);
                                      print(response.body);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PASSCODE(
                                                  houers: hours,
                                                  minutes: minutes,
                                                  Lat: double.parse(snapshot
                                                      .data[index]['Latitude']),
                                                  Long: double.parse(
                                                      snapshot.data[index]
                                                          ['longitude']),
                                                  sA: double.parse(snapshot
                                                      .data[index]['Area']),
                                              uid: widget.uid,
                                              sid:snapshot.data[index]['S_ID'] ,
                                              Crowd: lev,
                                              Ttime:nDatee.toString() ,
                                                )),
                                      );
                                      print(snapshot.data[index]['Latitude']);
                                      print(snapshot.data[index]['longitude']);
                                      print(double.parse(
                                          snapshot.data[index]['Area']));
                                    },
                                    color: const Color(0xff4db8ac),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    child: Text(
                                      "BOOK",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Segoe UI',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                              );
                          }
                        }),
                  ),
                  Transform.translate(
                      offset: Offset(-106.0, -18.0),
                      child: FutureBuilder(
                          future: getSuper,
                          // ignore: missing_return
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              case ConnectionState.done:
                                double distanceInMeters =
                                    Geolocator.distanceBetween(
                                        Lat,
                                        Long,
                                        double.parse(
                                            snapshot.data[index]['Latitude']),
                                        double.parse(
                                            snapshot.data[index]['longitude']));
                                return Transform.translate(
                                  offset: Offset(140, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xff4db8ac),
                                        size: 25.0,
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      ),
                                      Text(
                                        '${d.format(distanceInMeters / 1000)} KM',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 20,
                                          color: const Color(0xffde445f),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                            }
                            ;
                          })),

                ]));
          },

        )));
    ;
  }
}
