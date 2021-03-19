import 'dart:convert';
import 'package:flutter/material.dart';
import '../backend/server.dart' as server;
import '../models/http_exception.dart';
import 'tabs_screen.dart';

import 'package:http/http.dart' as http;

enum AuthMode { login, signup }

class AuthScreen extends StatelessWidget {
  static const routeName = 'auth-screen';
  @override
  Widget build(BuildContext context) {
    final _isInit = ModalRoute.of(context).settings.arguments as bool;
    //final devicesize = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.5,
        color: Color(0xFF52796f), //40916c //cdb4db 457b9d eddcd2
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top * 2,
            ),
            Flexible(
              child: Container(
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/iiitbh_logo.png',
                    alignment: Alignment.center,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Flexible(child: AuthCard())
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  bool isInit = true;
  AuthCard([inInit]);
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  bool _isAuth = false;
  bool _isButtonLoading = false;
  FocusNode _focusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool validatePassword(String value) {
    String pattern = r'/^(a-zA-Z0-9_-=!@#$%^&*)$/';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  var _isLoading = true;
  //var _authMode = AuthMode.login;
  var _userIdContoller = TextEditingController();
  var _passwordController = TextEditingController();

  Map<String, String> _authData = {
    'userId': '',
    'password': '',
  };

  Future<void> _submit() async {
    final _isValid = _formKey.currentState.validate();
    if (!_isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isButtonLoading = true;
    });

    void _errorDialog(String errorMsg) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
            title: Text('An error occured'),
            content: Text(errorMsg),
            //backgroundColor: Colors.black,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          );
        },
      );
    }

    try {
      final url = 'http://localhost:3000/login';
      final response = await http.get(
          '$url?login=${_userIdContoller.text}&password=${_passwordController.text}');
      final extractedData = json.decode(response.body);
      if (extractedData['user_exists'] == 'Yes') {
        if (extractedData['verified'] == 'Yes') {
          _isAuth = true;
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName,
              arguments: [_isAuth, _userIdContoller.text]);
        } else if (extractedData['verified'] == 'No') {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    content: Text('Username or password incorrect'),
                    title: Text('Authentication Failed'),
                    titleTextStyle: TextStyle(
                      fontFamily: 'Prompt',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFfaedcd))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Okay',
                          style: TextStyle(fontFamily: 'Prompt', fontSize: 15),
                        ),
                      )
                    ],
                  ));
        }
      } else if (extractedData['user_exists'] == 'No') {}
    } on HttpException catch (_) {
      var errorMessage = 'Authentication Failed!!';
      _errorDialog(errorMessage);
    } catch (error) {
      print(error);
    }
    setState(() {
      _isButtonLoading = false;
    });
  }

  //bool _isInit = true;

  // @override
  // void initState() {
  //   serverCall();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    // if (widget.isInit) {
    //   serverCall();
    // }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _userIdContoller.dispose();
    _passwordFocusNode.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        //_isLoading
        //     ? Container(
        //         margin: EdgeInsets.symmetric(
        //             vertical: MediaQuery.of(context).size.height * 0.05),
        //         child: CircularProgressIndicator()):
        Card(
      borderOnForeground: false,
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      shadowColor: Color(0xFF01497c),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF03045e),
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    labelText: 'UserId ',
                    hintStyle: TextStyle(color: Colors.black45),
                    hintText: 'Example: x004',

                    //floatingLabelBehavior: FloatingLabelBehavior.always
                    labelStyle: TextStyle(
                        fontFamily: 'Prompt',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF03045e)),

                    //focusColor: Color(0xFFb7094c),
                  ),
                  controller: _userIdContoller,
                  //autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty || value.length < 3) {
                      return 'Invalid userId address';
                    }
                    return null;
                  },

                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                    //_authData['email'] = value;
                  },
                  onSaved: (value) {
                    _authData['userId'] = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0xFF03045e),
                        width: 2,
                      ),
                    ),
                    errorMaxLines: 2,
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Prompt',
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontFamily: 'Prompt',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF03045e)),
                  ),
                  keyboardType: TextInputType.text,
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'A password must contain at least 6 characters';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    _authData['password'] = value;
                    _submit;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45),
                margin: EdgeInsets.symmetric(vertical: 15),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.merge(BorderSide.none, BorderSide.none),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: _submit,
                  splashColor: Colors.red,
                  backgroundColor: Colors.blue,
                  child: _isButtonLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Login',
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
