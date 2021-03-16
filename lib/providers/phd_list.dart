import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:mongo_dart/mongo_dart.dart';
// import '../backend/server.dart' as server;
import 'package:http/http.dart' as http;

// Future<List<Aprof>> getAprof() async {
//   final url = 'http://localhost:3000/listPage/Aprof';
//   final response = await http.get(url);

//   final jsonResponse = json.decode(response.body.toString());
//   final dataList = AprofList.fromJson(jsonResponse['list']).list;
//   return dataList;
// }

class Phd {
  final String userId;
  final String name;
  final String dept;
  final String education;
  final String DoJ;

  Phd({this.userId, this.name, this.dept, this.education, this.DoJ});

  factory Phd.fromJson(Map<String, dynamic> json) {
    return Phd(
        userId: json['userId'],
        name: json['name'],
        dept: json['dept'],
        education: json['education'],
        DoJ: json['DoJ']);
  }
}

class PhdList with ChangeNotifier {
  final List<Phd> list;

  PhdList({
    this.list,
  });

  factory PhdList.fromJson(List<dynamic> parsedJson) {
    var list = <Phd>[];
    list = parsedJson.map((i) => Phd.fromJson(i)).toList();

    return PhdList(
      list: list,
    );
  }

  List<Phd> get phdList {
    return list;
  }
}
