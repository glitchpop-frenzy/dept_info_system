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

class Resources {
  final String id;
  final String type;
  final double capacity;
  final String dept;
  final String labAss;

  Resources({this.id, this.type, this.dept, this.capacity, this.labAss});

  factory Resources.fromJson(Map<String, dynamic> json) {
    return Resources(
        id: json['id'],
        type: json['type'],
        dept: json['dept'],
        capacity: json['capacity'],
        labAss: json['LabAsst']);
  }
}

class ResourcesList with ChangeNotifier {
  final List<Resources> list;

  ResourcesList({
    this.list,
  });

  factory ResourcesList.fromJson(List<dynamic> parsedJson) {
    var list = <Resources>[];
    list = parsedJson.map((i) => Resources.fromJson(i)).toList();

    return ResourcesList(
      list: list,
    );
  }

  List<Resources> get resourcesList {
    return list;
  }
}
