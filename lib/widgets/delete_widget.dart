import 'dart:convert';

import 'package:flutter/material.dart';
import '../screens/auth_screen.dart';
import 'package:http/http.dart' as http;

class DeleteAccount extends StatefulWidget {
  String _userId;
  DeleteAccount(this._userId);
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _password = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    bool _isLoading = false;
    Future<void> passwordVerification(String password) async {
      String url =
          'http://localhost:3000/login/login=${widget._userId}&password=$password';
      bool verified = false;

      setState(() {
        _isLoading = true;
      });
      final response = await http.get(url);

      final extractedData = json.decode(response.body);
      setState(() {
        _isLoading = false;
      });
      if (extractedData['verified'] == 'Yes')
        verified = true;
      else
        verified = false;
    }

    Future<void> _saveForm() async {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
    }

    void confirm() {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: Text(
                'Authentication Required!!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              title: Text('Enter password to delete your account: '),
              actions: [
                Column(children: [
                  Form(
                    key: _formKey,
                    child: ListView(children: [
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2))),
                        controller: _password,
                        obscureText: true,
                        onSaved: (value) {
                          _password.text = value;
                        },
                        validator: (value) {
                          if (_password.text.isEmpty) {
                            return 'Password field cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Container(
                          child: Text('Cancel'),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          child: Text('Delete Account'),
                        ),
                      )
                    ],
                  )
                ]),
              ],
            );
          });
    }

    void deleteAcc() {
      // final url = 'http://localhost:3000/delete?userId=${widget._userId}';
      // http.delete(url);
      confirm();
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    }

    return Container();
  }
}
