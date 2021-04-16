import 'dart:async';

import 'package:crwordapp/Find.dart';
import 'package:crwordapp/gMapD.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import './Menu.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import './Report.dart';


class PASSCODE extends StatefulWidget{
  final int houers;
  final int minutes;
  final double Lat;
  final double Long;
  final double sA;
  final String uid;
  final String sid;
  final String Ttime;
  final  Crowd;
  const PASSCODE({Key key, this.houers, this.minutes, this.Lat, this.Long, this.sA, this.uid, this.sid, this.Ttime, this.Crowd}) : super(key: key);

  @override
  _PASSCODE createState() { return  _PASSCODE();
  }


}
class _PASSCODE extends State<PASSCODE> {
  int _Min;
  int _hour;
  int _Sec = 60;
  var m = NumberFormat("00", "en_US");
  var h = NumberFormat("00", "en_US");
  var s = NumberFormat("00", "en_US");

  Timer _timer;
  Timer _trakcer;
  Timer tracker;
  Timer _check ;


  void initState() {
    super.initState();
    getQr();
    startTimer();
    checkTicket();
    Track();

    print(widget.houers.toString());

  }

  var Data;
  var UserName;
  var stat=0;
  getQr() async {
    var query =
        "SELECT MAX(TR_ID) as A FROM `trip` WHERE U_ID=${widget.uid} AND S_ID=${widget.sid}";
    final response = await http.post(
        Uri.parse(
            "http://172.20.10.4/getData.php"),
        body: {'query': query});
    print(response.statusCode);
    Data=json.decode(response.body)[0]['A'];
    insertTick();

    print(response.body);
  }
  var stats;
  insertTick() async {
    var now = new DateTime.now();
    var nDate = new DateTime.now();
    var nDatee = DateFormat('yyyy-MM-dd').format(nDate);

    String formattedStratTime =
    DateFormat('hh:mm:ss').format(now);

    var lev;
    print(" ${widget.Crowd},'${0}','${nDatee}', '${formattedStratTime}', '${widget.sid}','${Data}','${widget.uid}");
    var query =
        "INSERT INTO Ticket (Crowd_level,Status,Date, time, S_ID, TR_ID, U_ID) VALUES( ${widget.Crowd},'${0}','${nDatee}', '${formattedStratTime}', '${widget.sid}','${Data}','${widget.uid}');";
    final response = await http.post(
        Uri.parse(
            "http://172.20.10.4/indata.php"),
        body: {'query': query});
    print(response.statusCode);
    print(response.body);
  }

  checkTicket () async{
  const oneSecon = Duration(seconds:30);

  _check = Timer.periodic(
      oneSecon,
          (Timer tracker) {
        if (mounted) setState(() async {
  print("++++++++++**************  $Data    ${widget.sid}***************+++++++++");
  var query =
      "SELECT count(TR_ID) as A From Active where TR_ID=${Data} AND S_ID=${widget.sid}";
  final response = await http.post(
      Uri.parse(
          "http://172.20.10.4/getData.php"),
      body: {'query': query});
  print(response.statusCode);
  stats=json.decode(response.body)[0]['A'];
  if (json.decode(response.body)[0]['A'] == '1') {
      print("sssssssssssssssss 1");
      setState(() {
        stat=1;
        startTimer();
      });
      _check.cancel();
    }
    else {
      final snackBar = SnackBar(content: Text('Please Wait until admin let you enter'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


);});
}
   startTimer() {
     _Min=widget.minutes;
     _hour=widget.houers;
    if (stat==1){
      const oneSeco = Duration(seconds:1);
      _timer = Timer.periodic(
          oneSeco,
              (Timer timer){ if (mounted) {
            setState(()  {
              if (_Sec == 0 && _Min == 0 && _hour == 0) {
                final snackBar = SnackBar(content: Text('Your has been over plesase go to the casher counter'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                timer.cancel();
              } else {
                if (_Sec ==0){
                  if (_Min ==0){
                    _hour--;
                    _Min=60;
                  }
                  _Min--;
                  _Sec=60;
                }
                _Sec--;

              }
            });}


          });
    }
   }

  void Track() {
  const oneSec = Duration(seconds:30);
  _trakcer = Timer.periodic(
      oneSec,
          (Timer tracker) {
            if (mounted) setState(() {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high, distanceFilter: 10);
    var x;
    var r;
    bool inSuper;
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        distanceFilter: 10).listen(
            (Position position) async {
          Geolocator.distanceBetween(
              widget.Lat, widget.Long, position.latitude, position.longitude);
          x = Geolocator.distanceBetween(
              widget.Lat, widget.Long, position.latitude, position.longitude);
          r = widget.sA / pi;
          inSuper = x > r;
          if (inSuper == true) {
            var query =
                "DELETE FROM active WHERE  where active.TR_ID=${Data} ";
            final response = await http.post(
                Uri.parse(
                    "http://172.20.10.4/getData.php"),
                body: {'query': query});
            print(response.statusCode);
            /*DELETE FROM `active` WHERE `active`.`TR_ID` = 107*/
            Navigator.popUntil(context, ModalRoute.withName("/Find"));
            _trakcer.cancel();
          };

          print(inSuper);
          print(position == null ? 'Unknown' : position.latitude.toString() +
              ', ' + position.longitude.toString());
        }
        )
    ;
  });});}



  @override
  void dispose() {
    tracker.cancel();
    _trakcer.cancel();
    _timer.cancel();
    _check.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(


        title: const Text('Ticket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700 , fontSize: 25 ), ),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Menu()),
              );
            },
            child: Icon(Icons.menu, color: Colors.white, size: 35,)),
        centerTitle: true ,

      ),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(40.0, 30.0),
            child: Container(
              width: 350.0,
              height: 450.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xbff5f5f5),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(40.0, 580.0),
            child: Container(
              width: 350.0,
              height: 130.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xbff5f5f5),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(40.0, 500.0),
            child: Container(
              width: 350.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color:  Colors.black26,
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(40.0, 500.0),
            child: Container(
              width: 232.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xff4db8ac),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(40.0, 500.0),
            child: Container(
              width: 116.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xffde445f),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              'Your Ticket',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 35,
                color: const Color(0xffde445f),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
         Container(
           alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 220, 180),
            child: Text('${widget.houers} ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 40,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 20, 180),
            child: Text(' ${_Min} ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 40,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(220, 0, 0, 180),
            child: Text('${_Sec}',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 40,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: new  EdgeInsets.fromLTRB(0, 0, 0, 40),
            child:  MaterialButton(
                minWidth: 336,
                height: 41,
                onPressed: (){
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => Find()),
                  );
                },
                color: const Color(0xffde445f),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
                child:  Text(
                  "END",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )

            ),
          ),
      Container(
        alignment: Alignment.topCenter,
        padding: new EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Text(
              'Shop Safely',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 23,
                color: const Color(0xff4db8ac),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          QrImage(
            foregroundColor: Colors.black,
            padding: EdgeInsets.fromLTRB(70, 160, 0, 0),
            size: 450,
            data:"${Data}",
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: new  EdgeInsets.fromLTRB(160, 0, 0, 90),
            child:  MaterialButton(
                minWidth: 116,
                height: 41,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Report()),
                  );
                },
                color:  Colors.black12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
                child:  Text(
                  "REPORT CROWD",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )

            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: new  EdgeInsets.fromLTRB(0, 0, 180, 90),
            child:  MaterialButton(
                minWidth: 150,
                height: 41,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => gMapD(Lat: widget.Lat,Long: widget.Long,)),
                  );
                },
                color: const Color(0xff4db8ac),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
                child:  Text(
                  "Dirction",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )

            ),
          ),



        ],
      ),
    );
  }
}
