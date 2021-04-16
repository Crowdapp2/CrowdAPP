import 'dart:convert';

import 'package:crwordapp/AdminHome.dart';
import 'package:flutter/material.dart';
import 'Find.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class login2 extends StatefulWidget{
  final TextEditingController phonen;

  const login2({Key key, this.phonen}) : super(key: key);
  @override
  _login2 createState()=>_login2();

}

// ignore: camel_case_types
class _login2 extends State<login2> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController sms = new TextEditingController();
  TextEditingController _OTP = new TextEditingController();


  String _verifcationCode;
  @override
  void initState() {
    super.initState();
    _OTP.text=genOTP();
    _verifcationCode=_OTP.text;
    sendOTP();

  }

  genOTP (){
    String verifcationCode;
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var randomizer = new Random();
    var otp = (min + randomizer.nextInt(max - min)).toString();
    print(otp);
    return otp;
  }
  sendOTP() async{
    final res = await http.get("http://172.20.10.4/sendotp.php?phone=+966${widget.phonen.text}&msg=your crowdapp OTP: ${_verifcationCode}");
    if (res.statusCode==200){
      print("sent ");
    }
  }
  var Uid,Sid;
  getUID() async{
    var query = "SELECT U_ID FROM users where phoneNum = ${widget.phonen.text}";
    final response = await http
        .post(Uri.parse("http://172.20.10.4/getData.php"), body: {'query': query});
    print(response.statusCode);
    if (response.statusCode == 200) {
      Uid= (json.decode(response.body)[0]["U_ID"]);
      print("u: ${Uid}");
      getSID();


    }
  }
  getSID() async{
    var query = "SELECT S_ID FROM manage where U_ID = ${Uid}";
    final response = await http
        .post(Uri.parse("http://172.20.10.4/getData.php"), body: {'query': query});
    print(response.statusCode);
    if (response.statusCode == 200) {
      Sid= (json.decode(response.body)[0]["S_ID"]);
      print("s: ${Sid}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(175.0, 540.0),
            child: SizedBox(
              width: 92.0,
              height: 35.0,
              child: Text(
                'Send again',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 16,
                  color: const Color(0xff929292),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 130),
            child: SizedBox(
              width: 230.0,
              height: 86.0,
              child: Text(
                'Verification',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 39,
                  color: const Color(0xffde445f),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Container(
              width: 320.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                border: Border.all(
                    width: 1.0, color: Colors.grey.withOpacity(0.7)),
              ),
              child: TextField(
                controller: _OTP,
                scrollPadding: new EdgeInsets.fromLTRB(0, 0, 0, 100),
                autofocus: false,
                showCursor: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),

              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: SizedBox(
              width: 200.0,
              height: 18.0,
              child: SingleChildScrollView(
                  child: Text(
                    'Send to +966 ${widget.phonen.text} ',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: new EdgeInsets.fromLTRB(0, 180, 0, 0),
            child: MaterialButton(
                minWidth: 320,
                height: 45,
                onPressed: (){
                  if(_OTP.text==_verifcationCode){
                    getUID();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHome(Uid:Uid,Sid:Sid)),);}
                  else if (_OTP.text != _verifcationCode){
                    final snackBar = SnackBar(content: Text('Worng OTP'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }
                },
                color: const Color(0xff61cec3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Text(
                  "Send",
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