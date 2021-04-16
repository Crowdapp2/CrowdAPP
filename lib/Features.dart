// To parse this JSON data, do
//
//     final features = featuresFromJson(jsonString);

import 'dart:convert';

Features featuresFromJson(String str) => Features.fromJson(json.decode(str));

String featuresToJson(Features data) => json.encode(data.toJson());

class Features {
  Features({
    this.features,
  });

  List<Feature> features;

  factory Features.fromJson(Map<String, dynamic> json) => Features(
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
  };
}

class Feature {
  Feature({
    this.attributes,
  });

  Attributes attributes;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes.toJson(),
  };
}

class Attributes {
  Attributes({
    this.confirmed,
    this.dataSource,
    this.deaths,
    this.govCode,
    this.globalId,
    this.governorateNameEn,
    this.nameEng,
    this.newAdded,
    this.objectid1,
    this.objectId,
    this.plcCode,
    this.placeNameEn,
    this.placeCategory,
    this.placeCode,
    this.regCode,
    this.recovered,
    this.regionNameEn,
    this.reportdt,
    this.tested,
  });

  int confirmed;
  String dataSource;
  int deaths;
  String govCode;
  String globalId;
  String governorateNameEn;
  String nameEng;
  int newAdded;
  dynamic objectid1;
  int objectId;
  String plcCode;
  String placeNameEn;
  String placeCategory;
  String placeCode;
  String regCode;
  int recovered;
  String regionNameEn;
  int reportdt;
  int tested;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    confirmed: json["Confirmed"],
    dataSource: json["DataSource"],
    deaths: json["Deaths"],
    govCode: json["GOV_CODE"],
    globalId: json["GlobalID"],
    governorateNameEn: json["GovernorateName_EN"],
    nameEng: json["Name_Eng"],
    newAdded: json["NewAd ded"],
    objectid1: json["OBJECTID_1"],
    objectId: json["ObjectId"],
    plcCode: json["PLC_CODE"],
    placeNameEn: json["PlaceName_EN"],
    placeCategory: json["Place_Category"],
    placeCode: json["Place_Code"],
    regCode: json["REG_CODE"],
    recovered: json["Recovered"],
    regionNameEn: json["RegionName_EN"],
    reportdt: json["Reportdt"],
    tested: json["Tested"],
  );

  Map<String, dynamic> toJson() => {
    "Confirmed": confirmed,
    "DataSource": dataSource,
    "Deaths": deaths,
    "GOV_CODE": govCode,
    "GlobalID": globalId,
    "GovernorateName_EN": governorateNameEn,
    "Name_Eng": nameEng,
    "NewAdded": newAdded,
    "OBJECTID_1": objectid1,
    "ObjectId": objectId,
    "PLC_CODE": plcCode,
    "PlaceName_EN": placeNameEn,
    "Place_Category": placeCategory,
    "Place_Code": placeCode,
    "REG_CODE": regCode,
    "Recovered": recovered,
    "RegionName_EN": regionNameEn,
    "Reportdt": reportdt,
    "Tested": tested,
  };
}
