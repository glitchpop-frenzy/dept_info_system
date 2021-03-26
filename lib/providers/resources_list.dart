import 'package:flutter/foundation.dart';

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
