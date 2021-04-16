/* import 'package:flutter/material.dart';
import 'MoeAPI.dart';
import 'Features.dart';

class GetAPI extends StatefulWidget {

  GetAPI() : super();


  @override
  _GetAPIState createState() => _GetAPIState();
}


class _GetAPIState extends State<GetAPI>{

  List<Features> _features ;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true ;
    MoeAPI.getFeatures().then((data) {
      _features = data ;
      _loading = false ;

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(  _loading ? 'Loading ...': 'Features')
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(itemBuilder: (context , index){
           Future future = _features[index] as Future;
          return ListTile(
            title: Text(Feature),

          )

        }),
      ),

    );

  }
  
  
 */