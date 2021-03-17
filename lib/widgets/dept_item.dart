import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screens/dept_faculty_screen.dart';

//import '../screens/dept_screen.dart';

class DeptItem extends StatelessWidget {
  final String title;
  final List<int> color;

  DeptItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        onTap: () {
          // print('tapped');
          Navigator.of(context).pushNamed(DeptFacultyScreen.routeName,
              arguments: [title, ...color]);
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(color[0]),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
