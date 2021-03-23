import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'aprof_screen.dart';
import 'resources_screen.dart';
import 'phd_screen.dart';
import 'prof_screen.dart';

class FacultyScreen extends StatelessWidget {
  TextStyle textStyle(double size) {
    return TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w500,
      fontSize: size,
    );
  }

  static const routeName = '/faculty-category-screen';
  // FacultyCategoryScreen();
  @override
  Widget build(BuildContext context) {
    //final title = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
            leading: Icon(
              Icons.school,
              size: 30,
            ),
            title: Text(
              'Faculty',
              style: TextStyle(color: Colors.black),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFf8edeb), Color(0xFFcaf0f8)]),
              ),
            ),
          )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF01497c), Color(0xFFefd9ce)], //0xFF134074
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF9ec1a3))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProfScreen.routeName,
                        arguments: ['Professors', 0xFF9ec1a3]);
                  },
                  child: Center(
                      child: Text(
                    'Professors',
                    style: textStyle(38),
                  )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFefd9ce))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AprofScreen.routeName,
                        arguments: ['Assistant Professors', 0xFFefd9ce]);
                  },
                  child: Center(
                      child: Text(
                    'Assistant Professors',
                    style: textStyle(35),
                  )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFffafcc))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(PhdScreen.routeName,
                        arguments: ['PhD Students', 0xFFffafcc]);
                  },
                  child: Center(
                      child: Text(
                    'PhD Students',
                    style: textStyle(36),
                  )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                height: MediaQuery.of(context).size.height * 0.20,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFcdb4db))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ResourcesScreen.routeName,
                        arguments: ['Resources', 0xFFcdb4db]);
                  },
                  child: Center(
                      child: Text(
                    'Resources',
                    style: textStyle(35),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
