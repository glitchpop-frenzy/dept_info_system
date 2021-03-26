import 'package:flutter/foundation.dart';

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
