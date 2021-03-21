import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  static const routeName = 'change-password';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String userid;
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _confirmPassword.dispose();
    _newPassword.dispose();
    _currentPassword.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    userid = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }

  void _saveForm(String curr) async {
    final _isValid = _formKey.currentState.validate();
    if (!_isValid) {
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final checkUrl =
          'http://localhost:3000/login?login=$userid&password=$curr';
      final response1 = await http.get(checkUrl);
      final extractedData1 = json.decode(response1.body)['verified'];
      setState(() {
        _isLoading = false;
      });
      if (extractedData1 == 'No') {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        color: Color(0xFFffd8be),
                        padding: EdgeInsets.all(7),
                        child: Text(
                          'Okay',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  )
                ],
                title: Text('Authentication Status'),
                content: Text('Authentication Failed!! Please try again'),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            });

        return;
      }

      final url = 'http://localhost:3000/editProfile/password?userId=$userid';
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            'userId': userid,
            'newData': {
              'userId': userid,
              'password': _confirmPassword.text,
            }
          },
        ),
      );
      setState(() {
        _isLoading = false;
      });
      final extractedData = json.decode(response.body)['updated'];
      if (extractedData == 'true') {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ))
                ],
                title: Text('Password Update'),
                content: Text('Password Changed Successfully!!'),
                //backgroundColor: Colors.black,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    //style: ButtonStyle(textStyle: MaterialStateProperty.all()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )
                ],
                title: Text('Password Update'),
                content: Text('Password Change Failed!!'),
                //backgroundColor: Colors.black,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          title: Text('Reset Password'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0091ad), Color(0xFF0091ad)],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _saveForm(_currentPassword.text);
              },
              icon: Icon(
                Icons.save_outlined,
                size: 35,
              ),
            )
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(color: Color(0xFFffeedd)),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xFF415a77),
                              width: 3,
                            ),
                          ),
                          labelText: 'Enter current password ',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF3f4238),
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xFF5a189a),
                              )),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          errorMaxLines: 2),
                      obscureText: true,
                      controller: _currentPassword,
                      validator: (value) {
                        if (_currentPassword.text == null) {
                          return 'This field cannot be null';
                        } else if (_currentPassword.text.length < 6) {
                          return 'Password should contain 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _currentPassword.text = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xFF415a77),
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xFF5a189a),
                              )),
                          labelText: 'Enter new password ',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF3f4238),
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          errorMaxLines: 2),
                      obscureText: true,
                      controller: _newPassword,
                      validator: (value) {
                        if (_newPassword.text == null) {
                          return 'This field could be null';
                        } else if (_newPassword.text.length < 6) {
                          return 'Password should contain 6 characters';
                        } else if (_confirmPassword.text != _newPassword.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newPassword.text = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xFF415a77),
                              width: 3,
                            ),
                          ),
                          labelText: 'Confirm new password ',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF3f4238),
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w500,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xFF5a189a),
                              )),
                          errorMaxLines: 2),
                      obscureText: true,
                      controller: _confirmPassword,
                      validator: (value) {
                        if (_confirmPassword.text == null) {
                          return 'This field could be null';
                        } else if (_confirmPassword.text.length < 6) {
                          return 'Password should contain 6 characters';
                        } else if (_confirmPassword.text != _newPassword.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _confirmPassword.text = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
