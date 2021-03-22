import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:mongo_dart/mongo_dart.dart';
// import '../backend/server.dart' as server;
// import 'package:http/http.dart' as http;

// Future<List<Prof>> getAprof() async {
//   final url = 'http://localhost:3000/listPage/prof';
//   final response = await http.get(url);

//   final jsonResponse = json.decode(response.body.toString());
//   final dataList = ProfList.fromJson(jsonResponse['list']).list;
//   return dataList;
// }

class Prof {
  final String userId;
  final String name;
  final String dept;
  final String education;
  final String DoJ;
  final String additional;

  Prof(
      {this.userId,
      this.name,
      this.dept,
      this.education,
      this.DoJ,
      this.additional});

  factory Prof.fromJson(Map<String, dynamic> json) {
    return Prof(
        userId: json['userId'],
        name: json['name'],
        dept: json['dept'],
        education: json['education'],
        DoJ: json['DoJ'],
        additional: json['additional']);
  }
}

class ProfList with ChangeNotifier {
  final List<Prof> list;
  // Future<List<Prof>> gap() async {
  //   final dataList = await getAprof();
  //   return dataList;
  // }

  ProfList({
    this.list,
  });

  factory ProfList.fromJson(List<dynamic> parsedJson) {
    var list = <Prof>[];
    list = parsedJson.map((i) => Prof.fromJson(i)).toList();

    return ProfList(
      list: list,
    );
  }

  List<Prof> get profList {
    return list;
  }
}
