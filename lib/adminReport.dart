import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './Menu.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class adminReport extends StatelessWidget {
  adminReport({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
        appBar: AppBar(


          title: const Text('Reports', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700 , fontSize: 25 ), ),
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

        body: Center( child: ListView.builder(
padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
    itemBuilder: (context, index) {
      return Card(
          margin: const EdgeInsets.all(16),
          child: Column(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0,-0),
                  child: Text(
                    'Supermarket name',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 25,
                      color: const Color(0xffde445f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(10,10),
                  child: Text(
                    'detilas detilas detilas detilas detilas detilas detilas detilas detilas detilas',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 13,
                      color: Colors.black26,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                Transform.translate(
                  offset: Offset(110.0, 30.0),
                  child: MaterialButton(
                      minWidth: 127,

                      color: const Color(0xff4db8ac),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70)
                      ),
                      onPressed: () {  },
                      child: Text(
                        "Accept",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      )

                  ),
                ),
                Transform.translate(
                  offset: Offset(-106.0, -18.0),
                  child: MaterialButton(
                      minWidth: 127,

                      color: const Color(0xffde445f),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70)
                      ),
                      onPressed: () {  },
                      child: Text(
                        "Reject",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      )

                  ),
                ),





              ] ));





    },
    itemCount: 4,

    ))
    );
  }
}
