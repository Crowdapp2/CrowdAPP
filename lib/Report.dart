import 'package:crwordapp/Find.dart';
import 'package:crwordapp/PASSCODE.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './Home.dart';
import 'package:adobe_xd/page_link.dart';
import './ReportSumary.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Menu.dart';

//new
class Report extends StatefulWidget {
  @override
  _Report createState() => _Report();

}

class _Report extends State<Report> {
   String _character = "High";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset : false,

      backgroundColor: const Color(0xffffffff),

    appBar:AppBar(


    title: const Text('REPORT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700 , fontSize: 25 ), ),
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


         Container(
           alignment: Alignment.center,
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
          Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              'Report Crowd',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 35,
                color: const Color(0xffde445f),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          Transform.translate(
            offset: Offset(120.0, 200.0),
            child: Text(
              'Supermarket Address',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color:  Colors.black26,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(120.0, 170.0),
            child: Text(
              'Supermarket name',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 22,
                color: const Color(0xffde445f),
              ),
              textAlign: TextAlign.left,
            ),
          ),



          Container(
            alignment: Alignment.bottomCenter,
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 160),
            child: Container(
              width: 280.0,
              height: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white.withOpacity(1),
                border: Border.all(width: 1.0, color:  Colors.grey.withOpacity(0.7)),
              ),
              child: TextField(
                scrollPadding: new  EdgeInsets.fromLTRB(0, 0, 0, 100) ,
                autofocus: false ,
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
          //login to register
          Container(
            width: 400,
            padding: new EdgeInsets.fromLTRB(15, 220, 0, 0),
            child: Column(

              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Radio(

                        value: "High",
                        groupValue: _character,

                        activeColor: Color(0xffde445f),

                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      Text('High Crowd',),

                      Radio <String>(
                        value: "Medium",
                        groupValue: _character,
                        activeColor: Color(0xffde445f),
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      Text ('Medium Crowd'),
                    ])],
            ),


          ),





          Container(
            alignment: Alignment.bottomCenter,
            padding: new  EdgeInsets.fromLTRB(10, 0, 0, 60),
            child:  MaterialButton(
                minWidth: 270,
                height: 45,
                onPressed: (){
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => PASSCODE()),
                  );
                },
                color: const Color(0xffde445f),
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

        ],
      ),
    );
  }
}
