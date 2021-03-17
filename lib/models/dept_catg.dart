import 'package:flutter/material.dart';

class DeptCategory {
  final int id;
  final String title;
  final List<int> color;

  const DeptCategory({
    @required this.id,
    @required this.title,
    @required this.color,
  });
}
