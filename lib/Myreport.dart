import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Myreport extends StatefulWidget {
  final String Uid;

  const Myreport({Key key, this.Uid}) : super(key: key);

  @override
  _Myreport createState() => _Myreport();
}

class _Myreport extends State<Myreport> {
  var m = NumberFormat("0000", "en_US");

  List trips;
  Future<List> getData() async {
    var query =
        " SELECT R_ID, report.Crowd_level , report.Time_Date  , report.Details,Supermarkets.Name,Supermarkets.S_ID FROM report LEFT JOIN Supermarkets on report.S_ID= Supermarkets.S_ID WHERE report.U_ID=${widget.Uid};";

    final response = await http
        .post(Uri.parse("http://10.0.2.2/getData.php"), body: {'query': query});
    print(response.statusCode);
    if (response.statusCode == 200) {
      trips = jsonDecode(response.body);
      print(trips);
    }
    size = trips.length;
    return trips;
  }
  var size;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          title: const Text(
            'History',
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
        body: Center(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.all(16),
                    child: Column(children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 60, 10),
                          alignment: Alignment.topCenter,
                          child: FutureBuilder(
                              future: getData(),
                              // ignore: missing_return
                              builder: (context, AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("none");
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return Text("{waiting}");
                                  case ConnectionState.done:
                                    return Text(
                                      ' Time & Date : ${snapshot.data[index]['Time_Date']}',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 18,
                                        color:  Colors.black45,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.left,
                                    );
                                }
                              })),

                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.topCenter,
                          child: FutureBuilder(
                              future: getData(),
                              // ignore: missing_return
                              builder: (context, AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("none");
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return Text("{waiting}");
                                  case ConnectionState.done:
                                    return Text(
                                      '# ${snapshot.data[index]['Name']}                    Crowd Level: ${snapshot.data[index]['Crowd_level']}',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 20,
                                        color:  Color(0xffde445f),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    );
                                }
                              })),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 60, 10),
                          alignment: Alignment.topCenter,
                          child: FutureBuilder(
                              future: getData(),
                              // ignore: missing_return
                              builder: (context, AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("none");
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return Text("{waiting}");
                                  case ConnectionState.done:
                                    return Text(
                                      ' Time & Date : ${snapshot.data[index]['Time_Date']}',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 18,
                                        color:  Colors.black45,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.left,
                                    );
                                }
                              })),
                      Container(
                          padding: EdgeInsets.fromLTRB(35, 10, 0, 10),
                          alignment: Alignment.topCenter,
                          child: FutureBuilder(
                              future: getData(),
                              // ignore: missing_return
                              builder: (context, AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("none");
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return Text("{waiting}");
                                  case ConnectionState.done:
                                    return Text(
                                      'Details: ${snapshot.data[index]['Details']}',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 18,
                                        color:  Colors.black45,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.left,
                                    );
                                }
                              })),


                    ]));
              },
              itemCount: size,
            )));
  }
}
