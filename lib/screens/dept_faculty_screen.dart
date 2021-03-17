//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:iiitbh_dept_info_system/screens/dept_phd_screen.dart';
import 'dept_phd_screen.dart';
import 'dept_prof_screen.dart';
import 'dept_aprof_screen.dart';

class DeptFacultyScreen extends StatelessWidget {
  static const routeName = 'dept-faculty-screen';
  @override
  Widget build(BuildContext context) {
    final dept = ModalRoute.of(context).settings.arguments as List;
    String title = dept[0];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
            title: Text('$title'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(dept[1]), Color(dept[2])],
                ),
              ),
            ),
          )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFe6beae), Color(0xFFdedbd2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                color: Color(0xFF1d3557),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF1d3557))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(DeptProfScreen.routeName,
                        arguments: [title, 0xFF1d3557]);
                  },
                  child: Center(
                      child: Text(
                    'Professors',
                    style: TextStyle(color: Color(0xFFf0efeb), fontSize: 45),
                  )),
                ),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            ClipRRect(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                color: Color(0xFF0b525b),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0b525b))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(DeptAprofScreen.routeName,
                        arguments: [title, 0xFF0b525b]);
                  },
                  child: Center(
                      child: Text(
                    'Assistant Professors',
                    style: TextStyle(color: Color(0xFFedf2fb), fontSize: 35),
                  )),
                ),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            ClipRRect(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                color: Color(0xFF1b4332),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF1b4332))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(DeptPhdScreen.routeName,
                        arguments: [title, 0xFF1b4332]);
                  },
                  child: Center(
                      child: Text(
                    'PhD Students',
                    style: TextStyle(color: Color(0xFFd8e2dc), fontSize: 45),
                  )),
                ),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
      ),
    );
  }
}
