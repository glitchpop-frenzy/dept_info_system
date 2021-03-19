import 'package:flutter/material.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'profile-screen';
  @override
  Widget build(BuildContext context) {
    //final _userId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
            title: Text(
              'Your Profile',
              style: TextStyle(color: Color(0xFFf8edeb)),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF272640), Color(0xFF006466)],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                tileColor: Color(0xFFfff1e6),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
