import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<dynamic>>  getCovid() async {

   Map data;
   bool a = false;
   bool b = false;
   int conf =0;
   var Dea = 0;
   var Rec = 0;
    List<dynamic> covidD = [];
    const String url = "https://services6.arcgis.com/bKYAIlQgwHslVRaK/arcgis/rest/services/VWPlacesCasesHostedView/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("200");
      a=true;

    }
    var dataLe;
    if(a==true){
      data = json.decode(response.body);
      dataLe = data["features"].length;
      print("hi ${dataLe}");
    }
    b=true;

    var all_city = new List();
    var date = new List();
    var maxD = 0;
    int i, j;
    for (data["features"][i = 0]["attributes"]["PlaceName_EN"]; i < dataLe; i++) {
      if (!all_city.contains(data["features"][i]["attributes"]["PlaceName_EN"])) {
        all_city.add(data["features"][i]["attributes"]["PlaceName_EN"]);
//  print(data["features"][i]["attributes"]["PlaceName_EN"]);
      }
    }
    int cityLen = all_city.length;
    for (all_city[i = 0]; i < cityLen; i++) {
      for (data["features"][j = 0]["attributes"]["Reportdt"]; j <
          dataLe; j++) {
        if (!date.contains(data["features"][j]["attributes"]["Reportdt"])) {
          date.add(data["features"][j]["attributes"]["Reportdt"]);
        }
        if (maxD < data["features"][j]["attributes"]["Reportdt"]) {
          maxD = data["features"][j]["attributes"]["Reportdt"];
        }
      }
      for (data["features"][j = 0]["attributes"]["Reportdt"]; j <
          dataLe; j++) {
        var dateCheck = data["features"][j]["attributes"]["Reportdt"];
        var cityCheck = data["features"][j]["attributes"]["PlaceName_EN"];
        if ((all_city[i] == cityCheck) && (maxD == dateCheck)) {

          conf += data["features"][j]["attributes"]["Confirmed"];
          Dea += data["features"][j]["attributes"]["Deaths"];
          Rec += data["features"][j]["attributes"]["Recovered"];


        }
      }
    }
    covidD.add(Rec);
    covidD.add(conf);
    covidD.add(Dea);
print(covidD);
   return covidD;
}




