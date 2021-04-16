import 'dart:convert';
import 'dart:ui';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';

import 'MoeAPI.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'adminReport.dart';
import 'package:http/http.dart ' as http;
import 'Menu.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminHome extends StatefulWidget {
  final String Uid;
  final String Sid;

  const AdminHome({Key key, this.Uid, this.Sid}) : super(key: key);
  @override
  _AdminHome createState() {
    return _AdminHome();
  }
}

class _AdminHome extends State<AdminHome> {
  String qrCodeResult = "Not Yet Scanned";

  Future covidFuture;
  @override
  void initState() {
    super.initState();
    getWaiting();
    reports= getReports();
    getMax();  }

  var reports;
  getReports() async {
    var query =
        "SELECT count(R_ID) as A From report LEFT JOIN manage on report.S_ID = manage.S_ID WHERE manage.U_ID=${widget.Uid};";
    final response = await http
        .post(Uri.parse("http://172.20.10.4/getData.php"), body: {'query': query});
    print(response.statusCode);
    print(response.body);
    reports = json.decode(response.body)[0]['A'];

  }

  var Max;
  var active ;
  getMax() async {
    var query =
        "SELECT COUNT(TR_ID) AS 'ActiveUser'  , Supermarkets.Max_user FROM Active LEFT JOIN Supermarkets on Active.S_ID= Supermarkets.S_ID where Active.S_ID =${widget.Sid} GROUP BY Active.S_ID;";
    final response = await http
        .post(Uri.parse("http://172.20.10.4/getData.php"), body: {'query': query});

    print(response.statusCode);
    print(response.body);
    Max=json.decode(response.body)[0]['Max_user'];
    active=json.decode(response.body)[0]['ActiveUser'];

  }

  var waiting;
  getWaiting() async {
    var query =
        "SELECT COUNT(TR_ID) as wait FROM ticket WHERE Status = 0 AND S_ID=${widget.Sid};";
    final response = await http
        .post(Uri.parse("http://172.20.10.4/getData.php"), body: {'query': query});
    print(response.statusCode);
    print(response.body);
    waiting=json.decode(response.body)[0]['wait'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text(
          'Home',
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
      body: Stack(
        children: <Widget>[
          // widget background boxes
          Transform.translate(
            offset: Offset(40.0, 30.0),
            child: Container(
              width: 350.0,
              height: 248.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xbff5f5f5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 350, 0, 0),
            child: Container(
              width: 350.0,
              height: 330.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xbff5f5f5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: Container(
              width: 350.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xbff5f5f5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),

          // Covid 19 widgit number boxes
          Container(
            child: Column(children: <Widget>[
              Container(
                child: Icon(
                  Icons.person_pin_circle_outlined,
                  color: const Color(0xed61cec3),
                  size: 50,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 90, 100, 0),
              ),
              Container(
                child: Icon(
                  Icons.av_timer_sharp,
                  color: const Color(0xed61cec3),
                  size: 45,
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 100, 0),
              ),
              Container(
                child: Icon(
                  Icons.warning,
                  color: const Color(0xed61cec3),
                  size: 45,
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 100, 0),
              ),
            ]),
          ),
          Transform.translate(
            offset: Offset(230,220),
            child: FutureBuilder(
                future: reports,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("none", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 23,
                        color:   Colors.black,
                        fontWeight: FontWeight.w700,
                      ),);
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Text("{waiting}", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),);
                    case ConnectionState.done:
                      return Text(
                        "Reports: ${reports}",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w700,
                        ),

                      );
                  }
                }),

          ),
          Transform.translate(
            offset: Offset(230,160),
            child: FutureBuilder(
                future: getMax(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("none", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 23,
                        color:   Colors.black,
                        fontWeight: FontWeight.w700,
                      ),);
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Text("{waiting}", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),);
                    case ConnectionState.done:
                      return  Text(
                        "Waiting: ${waiting}",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w700,
                        ),

                      );
                  }
                }),

          ),
          Transform.translate(
            offset: Offset(230,100),
            child: FutureBuilder(
                future: getMax(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("none", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color:   Colors.black45,
                        fontWeight: FontWeight.w700,
                      ),);
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Text("{waiting}", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.w700,
                      ),);
                    case ConnectionState.done:
                      return Text(
                        "Checked: ${active} / ${Max}",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w700,
                        ),

                      );
                  }
                }),

          ),

          // COVID 19 text head
          Transform.translate(
            offset: Offset(110, 45.0),
            child: SizedBox(
              width: 200.0,
              height: 30.0,
              child: SingleChildScrollView(
                  child: Text(
                    'Admin Dashborad',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 23,
                      color: const Color(0xffde445f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Transform.translate(
            offset: Offset(140, 400.0),
            child: SizedBox(
              width: 137.0,
              height: 30.0,
              child: SingleChildScrollView(
                  child: Text(
                    'QR SCANER',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 23,
                      color: const Color(0xffde445f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),

          //COVID-19 numbers  widgets
          //COVID-19 texts widgets

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Result",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12),
                  textAlign: TextAlign.center,
                ),
                Text(
                  qrCodeResult,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black12,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                // ignore: deprecated_member_use
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: MaterialButton(
              minWidth: 300,
              height: 45,
              padding: EdgeInsets.all(15.0),
              onPressed: () async {

                try{
                  final codeSanner = (await BarcodeScanner.scan()) as String;
                  if(mounted){//barcode scnner
                    setState(() {
                      qrCodeResult = codeSanner;
                    });}
                }catch (e){
                  BarcodeScanner.cameraAccessDenied;
                }

                var query =
                    "INSERT INTO active (TR_ID,S_ID) VALUES( '${qrCodeResult}',${widget.Sid});";
                final response = await http.post(
                    Uri.parse(
                        "http://172.20.10.4/indata.php"),
                    body: {'query': query});
                print(response.statusCode);
                print(response.body);
              },
              color: Color(0xffde445f),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              child: Text(
                "SCAN QR",
                style: TextStyle(
                    color: Color(0xffffffff), fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(60, 0, 0, 80),
              child: Row(children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xffde445f),
                  size: 50,
                ),
                MaterialButton(
                  minWidth: 260,
                  height: 45,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => adminReport()),
                    );
                  },
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  child: Text(
                    " View Reports",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}

