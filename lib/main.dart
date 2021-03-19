import 'package:flutter/material.dart';
import './screens/aprof_screen.dart';
import 'package:provider/provider.dart';
import './providers/prof_list.dart';
import './providers/phd_list.dart';
import './providers/resources_list.dart';

// import './backend/server.dart' as server;

import './screens/dept_phd_screen.dart';
import './screens/prof_screen.dart';
import './screens/phd_screen.dart';
import './screens/auth_screen.dart';
import './screens/dept_faculty_screen.dart';
import './screens/dept_prof_screen.dart';
import './screens/dept_aprof_screen.dart';
import './screens/faculty_screen.dart';
import './screens/resources_screen.dart';
import './screens/tabs_screen.dart';
import './screens/profile_screen.dart';
import 'backend/server.dart' as server;

void main() async {
  //await server.start();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  Future<void> serverCall() async {
    await server.start();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    server.start();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProfList(),
        ),
        ChangeNotifierProvider.value(
          value: ResourcesList(),
        ),
        ChangeNotifierProvider.value(
          value: PhdList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IIIT Dept. Info System',
        theme: ThemeData(
          primarySwatch: Colors.lime,
          accentColor: Color(0xFFffafcc),
          splashColor: Color(0xFFffafcc),
          textTheme:
              //073b4c
              TextTheme(
                  headline6: TextStyle(
                      //decoration: TextDecoration.lineThrough,
                      fontSize: 22.5,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headline6.color),
                  headline5: TextStyle(
                    color: Color(0xFF202c39),
                    fontSize: 22.5,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                  headline4: TextStyle(
                    //decoration: TextDecoration.lineThrough,
                    fontSize: 18.5,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                  headline3: TextStyle(
                    color: Color(0xFF202c39),
                    fontSize: 18.5,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  )),
        ),
        //home: TabsScreen(),
        home: AuthScreen(),
        routes: {
          //AuthCard.routeName: (ctx) => AuthCard(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen(),
          FacultyScreen.routeName: (ctx) => FacultyScreen(),
          ProfScreen.routeName: (ctx) => ProfScreen(),
          AprofScreen.routeName: (ctx) => AprofScreen(),
          PhdScreen.routeName: (ctx) => PhdScreen(),
          ResourcesScreen.routeName: (ctx) => ResourcesScreen(),
          DeptFacultyScreen.routeName: (ctx) => DeptFacultyScreen(),
          DeptProfScreen.routeName: (ctx) => DeptProfScreen(),
          DeptAprofScreen.routeName: (ctx) => DeptAprofScreen(),
          DeptPhdScreen.routeName: (ctx) => DeptPhdScreen(),
        },
      ),
    );
  }
}
