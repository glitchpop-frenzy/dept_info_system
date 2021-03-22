import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_screen.dart';
import 'change_password.dart';
import 'edit_credentials_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this._userId);
  final _userId;

  static const routeName = 'profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  Future<void> confirm(String type) async {
    final url =
        'http://localhost:3000/deleteProfile/$type?userId=${widget._userId}';
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(url);
    setState(() {
      _isLoading = false;
    });
    final extractedData = json.decode(response.body);

    SnackBar(
      duration: Duration(seconds: 5),
      elevation: 5,
      content: extractedData['updated'] == 'true'
          ? Text('Profile Deleted SUCCESSFULY!!')
          : Text('Profile deletion FAILED!!'),
    );
  }

  void deleteAccount(String userData) {
    String type;
    if (userData.startsWith('a')) {
      type = 'prof';
    } else if (userData.startsWith('b')) {
      type = 'Aprof';
    } else if (userData.startsWith('c')) {
      type = 'phd';
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmation'),
        content: Text(
          'Are you sure you want to delete your account?',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
              await confirm(type);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              color: Color(0xFFef233c),
              child: Container(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Color(0xFFfdfcdc), fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void userData(String userData) async {
    String url = 'http://localhost:3000/individualPage/';
    String type;

    if (userData.startsWith('a')) {
      type = 'prof';
    } else if (userData.startsWith('b')) {
      type = 'Aprof';
    } else if (userData.startsWith('c')) {
      type = 'phd';
    }
    url = '$url$type?userId=$userData';

    final response = await http.get(url);

    final extractedData = json.decode(response.body);
    //print(extractedData);

    Navigator.of(context).pushNamed(EditCredentials.routeName,
        arguments: [extractedData['userdata'], type]);
  }

  @override
  Widget build(BuildContext context) {
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
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                //color: Color(0xFFedf2fb),
                // decoration: BoxDecoration(color: Color(0xFFedede8)
                //     // gradient: LinearGradient(
                //     //     colors: [Color(0xFFbc4749), Color(0xFFd7e3fc)],
                //     //     begin: Alignment.topLeft,
                //     //     end: Alignment.bottomRight)
                //     ),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      tileColor: Color(0xFFfff1e6),
                      onTap: () {
                        userData(widget._userId);
                      },
                      leading: Icon(Icons.mode_edit),
                      title: Text(
                        'Edit Credentials',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Asap',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      tileColor: Color(0xFFfff1e6),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ChangePassword.routeName,
                            arguments: widget._userId);
                      },
                      leading: Icon(Icons.security_sharp),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Asap',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      tileColor: Color(0xFFfff1e6),
                      onTap: () => deleteAccount(widget._userId),
                      leading: Icon(Icons.delete_rounded),
                      title: Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Asap',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      tileColor: Color(0xFFfff1e6),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      leading: Icon(Icons.logout),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Asap',
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
