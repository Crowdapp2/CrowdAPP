import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart 'as http;

Future<List> insertData(String Table ,String name,String role,String Gender, String PhoneNum) async {
  final response = await http.post(Uri.parse("http://crowdapp.000webhostapp.com/indata.php"), body: {
    "Table":Table,
    "name": name,
    "role": role,
    "Gender":Gender,
    "phoneNum":PhoneNum
  });}