import 'package:crwordapp/loginAdmin.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_range/time_range.dart';
import './Verification.dart';
import 'package:http/http.dart ' as http;
import 'package:geolocator/geolocator.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'gMap.dart';
class Registera extends StatefulWidget {
  @override
  _Radmin createState() => _Radmin();

}
class _Radmin extends State<Registera> {


  TextEditingController NameC = new TextEditingController();
  TextEditingController SnameC = new TextEditingController();
  TextEditingController AreaC = new TextEditingController();
  TextEditingController PhoneC = new TextEditingController();

  TimeOfDay T = new TimeOfDay();

  Map<String, bool> values = {'agree': false,};
  String _character = 'Male';
  static const red = Color(0xffde445f);
  static const dark = Color(0xff4db8ac);


  TimeRangeResult _timeRange;



  @override
  void initState() {
    super.initState();

    _timeRange = null;
  }
  @override
  Widget build(BuildContext context) {
    MaterialApp (supportedLocales: [
      Locale('SA'),
    ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],);

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: const Color(0xffffffff),

      appBar: AppBar(


        title: const Text('Register', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Verification()),
              );
            },
           ),
        centerTitle: true,

      ),
      body: Stack(
        children: <Widget>[

          Transform.translate(
            offset: Offset(40.0, 30.0),
            child: Container(
              width: 350.0,
              height: 250.0,
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
            offset: Offset(115, 50.0),
            child: SizedBox(
              width: 210.0,
              height: 30.0,
              child: SingleChildScrollView(
                  child: Text(
                    'Admin Information',
                    style: TextStyle(

                      fontFamily: 'Segoe UI',
                      fontSize: 24,
                      color: const Color(0xffde445f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),

          Transform.translate(
            offset: Offset(40.0, 300.0),
            child: Container(
              width: 350.0,
              height: 340.0,
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
            offset: Offset(80, 320.0),
            child: SizedBox(
              width: 280.0,
              height: 30.0,
              child: SingleChildScrollView(
                  child: Text(
                    'Supermarket Information',
                    style: TextStyle(

                      fontFamily: 'Segoe UI',
                      fontSize: 24,
                      color: const Color(0xffde445f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(50, 500, 10, 0),
            width: 195,
            child: Column(
              children: <Widget>[
                Text("Shift 2",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),),

              TimeRange(

                  fromTitle: Text(
                    'Open From',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  toTitle: Text(
                    'Close In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: red,
                  ),
                  activeTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,

                  ),
                  borderColor: Colors.white.withOpacity(0),
                  backgroundColor: Colors.black12,
                  activeBackgroundColor: red,
                  activeBorderColor: Colors.white.withOpacity(0),
                  firstTime: TimeOfDay(hour: 00, minute: 00),
                  lastTime: TimeOfDay(hour:23 , minute: 30),
                  initialRange: _timeRange,
                  timeStep: 30,
                  timeBlock: 24,

                  onRangeCompleted: (range) => setState(() => _timeRange = range),

                ),


              ],),


          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(230, 500, 0,0 ),
            width: 380,
            child: Column(
              children: <Widget>[
                Text("Shift 1",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),),
                TimeRange(

                  fromTitle: Text(
                    'Open From',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  toTitle: Text(
                    'Close In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: red,
                  ),
                  activeTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,

                  ),
                  borderColor: Colors.white.withOpacity(0),
                  backgroundColor: Colors.black12,
                  activeBackgroundColor: red,
                  activeBorderColor: Colors.white.withOpacity(0),
                  firstTime: TimeOfDay(hour: 00, minute: 00),
                  lastTime: TimeOfDay(hour:23 , minute: 30),
                  initialRange: _timeRange,
                  timeStep: 30,
                  timeBlock: 24,

                  onRangeCompleted: (range) => setState(() => _timeRange = range),

                ),


              ],),


          ),

          //Name Text filed
          Container(

            alignment: Alignment.topCenter,
            padding: new EdgeInsets.fromLTRB(0, 100, 0,0),
            child: Container(
              width: 320.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
    ),

              child: TextField(
                controller: NameC,
                scrollPadding: new EdgeInsets.fromLTRB(30, 0, 0, 100),
                autofocus: false,
                showCursor: true,
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  contentPadding: new EdgeInsets.fromLTRB(15, 0, 0, 10),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),

              ),
            ),
          ),
          //phone Text filed
          Container(

            alignment: Alignment.topCenter,
            padding: new EdgeInsets.fromLTRB(120, 160, 0,0),
            child: Container(
              width: 200.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],

              ),
              child: TextField(
                controller: PhoneC,
                scrollPadding: new EdgeInsets.fromLTRB(0, 0, 0, 100),
                autofocus: false,
                showCursor: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: '5xxxxxxxx',
                    contentPadding: new EdgeInsets.fromLTRB(15, 0, 0, 10)
                ),


              ),
            ),
          ),
          //cuntery code
          Container(

            alignment: Alignment.topCenter,
            padding: new EdgeInsets.fromLTRB(0, 160, 230, 60),
            child: Container(
              width: 100.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],
                ),
              child: CountryCodePicker(
                onChanged: print,
                initialSelection: 'SA',
                favorite: ['SA'],
                showCountryOnly: true,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                flagWidth: 25,

              ),
            ),
          ),
          //gender
          Container(
            width: 400,
              padding: new EdgeInsets.fromLTRB(15, 220, 0, 0),
              child: Column(

                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                  Radio(

                    value: "Male",
                    groupValue: _character,

                    activeColor: Color(0xffde445f),

                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                        Text('Male',),

                        Radio <String>(
                    value: "Fmale",
                    groupValue: _character,
                    activeColor: Color(0xffde445f),
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                        Text ('Fmale'),
              ])],
              ),


            ),
//super name
          Container(

            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 50, 0,0),
            child: Container(
              width: 320.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],

              ),
              child: TextField(

                controller: SnameC,
                scrollPadding: new EdgeInsets.fromLTRB(0, 0, 0, 100),
                autofocus: false,
                showCursor: false,
                decoration: InputDecoration(
                  hintText: "Supermarket Name",
                  contentPadding: new EdgeInsets.fromLTRB(15, 0, 0, 10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),

              ),
            ),
          ),
// super area
          Container(

            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 160, 0, 0),
            child: Container(
              width: 320.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                    color : Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,

                  ),
                ],

              ),
              child: TextField(
                controller: AreaC,
                scrollPadding: new EdgeInsets.fromLTRB(0, 0, 0, 100),
                autofocus: false,
                showCursor: false,
                decoration: InputDecoration(
                  hintText: "Supermarket Area",
                  contentPadding: new EdgeInsets.fromLTRB(15, 0, 0, 10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),

              ),
            ),
          ),




          // register SUBMIT
          Container(
            alignment: Alignment.bottomCenter,
            padding: new EdgeInsets.fromLTRB(0,0, 0,25 ),
            child: MaterialButton(
                minWidth: 320,
                height: 45,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => gMap(name: NameC.text,phone: PhoneC.text,area: AreaC.text,char: _character,sName: SnameC.text,)),
                  );
                },
                color: const Color(0xff4db8ac),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Text(
                  "NEXT",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )

            ),
          ),

        ],),); }
}