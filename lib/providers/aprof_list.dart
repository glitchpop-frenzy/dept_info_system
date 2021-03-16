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

class Aprof {
  final String userId;
  final String name;
  final String dept;
  final String education;
  final String DoJ;

  Aprof({this.userId, this.name, this.dept, this.education, this.DoJ});

  factory Aprof.fromJson(Map<String, dynamic> json) {
    return Aprof(
        userId: json['userId'],
        name: json['name'],
        dept: json['dept'],
        education: json['education'],
        DoJ: json['DoJ']);
  }
}

class AprofList with ChangeNotifier {
  final List<Aprof> list;

  AprofList({
    this.list,
  });

  factory AprofList.fromJson(List<dynamic> parsedJson) {
    var list = <Aprof>[];
    list = parsedJson.map((i) => Aprof.fromJson(i)).toList();

    return AprofList(
      list: list,
    );
  }

  List<Aprof> get aprofList {
    return list;
  }
}
