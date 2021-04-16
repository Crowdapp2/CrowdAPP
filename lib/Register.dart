import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import './Verification.dart';
import 'package:geolocator/geolocator.dart';
import 'login1.dart';
import 'package:http/http.dart 'as http;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();

}

class _Register extends State<Register> {
  var Lat ;
  var Long;
  static LatLng _initialPosition;


  final Geolocator geolocator = Geolocator();
  Position _currentPosition;
  String _currentAddress;

   String  _character;
  TextEditingController NameC = new TextEditingController();
  TextEditingController RoleC = new TextEditingController();
  TextEditingController GenderC = new TextEditingController();
  TextEditingController PhoneC = new TextEditingController();

  void initState(){
    super.initState();
    _character = "Male";


  }


   // ignore: always_declare_return_types
   insertData() async {
    var query = "INSERT INTO Users( UserName, Role, Gender, phoneNum) VALUES('${NameC.text}', 'User', '${_character}', '${PhoneC.text}');";
    final response = await http.post(Uri.parse("https://172.20.10.4/indata.php"), body: {
      'query':query
    });
    print(response.statusCode);
    print(response.body);
  }

  Future<LatLng> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      Lat = position.latitude;
      Long = position.longitude;

    });}





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

    _getUserLocation();

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
            },),
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
            offset: Offset(40.0, 300.0),
            child: Container(

              width: 350.0,
              height: 310.0,
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
                  child: FutureBuilder(future: _getUserLocation(),
                     // ignore: missing_return
                     builder: (context , AsyncSnapshot snapshot) {
                    if (_initialPosition == Null){
                      return Text('Waiting Map');
                    }
                    else {
                      return GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 15,),);
                    }
                    }),
    ),
    ),

          Transform.translate(
            offset: Offset(115, 50.0),
            child: SizedBox(
              width: 210.0,
              height: 30.0,
    child: SingleChildScrollView(
    child: Text(
    'User Information',
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
          Container(
            alignment: Alignment.bottomCenter,
            padding: new EdgeInsets.fromLTRB(0,0, 0,50),
            child: MaterialButton(
                minWidth: 320,
                height: 45,
                onPressed: () {
                  insertData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login1()),
                  );
                },
                color: const Color(0xff4db8ac),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Text(
                  "SUBMIT",
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

