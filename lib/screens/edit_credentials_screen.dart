import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'profile_screen.dart';

class EditCredentials extends StatefulWidget {
  static const routeName = 'edit-credentials';
  @override
  _EditCredentialsState createState() => _EditCredentialsState();
}

class _EditCredentialsState extends State<EditCredentials> {
  bool _isInit = true;
  final _formKey = GlobalKey<FormState>();
  var _initValues = {
    'userId': '',
    'name': '',
    'dept': '',
    'education': '',
    'DoJ': '',
    'additional': ''
  };

  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _educController = TextEditingController();
  TextEditingController _dojController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print('_initValues = $_initValues');
      var jso = {
        'userId': _initValues['userId'],
        'newData': {
          'userId': _initValues['userId'],
          'name': _initValues['name'],
          'dept': _initValues['dept'],
          'education': _initValues['education'],
          'DoJ': _initValues['DoJ'],
          'additional': _initValues['additional']
        }
      };
      final url =
          'http://localhost:3000/editProfile/$type?userId=${_initValues['userId']}';

      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'userId': _initValues['userId'],
            'newData': {
              'userId': _initValues['userId'],
              'name': _initValues['name'],
              'dept': _initValues['dept'],
              'education': _initValues['education'],
              'DoJ': _initValues['DoJ'],
              'additional': _initValues['additional']
            }
          }));
      final extractedData = json.decode(response.body);
      if (extractedData['updated'] = true) {
        SnackBar(
          content: Text('Profile Updated Successfully!!'),
        );
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  String type;
  Map<String, dynamic> data;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final args = ModalRoute.of(context).settings.arguments as List;
      data = args[0];
      type = args[1];
      print(data);

      _initValues = {
        'userId': data['userId'],
        'name': data['name'],
        'dept': data['dept'],
        'education': data['education'],
        'DoJ': data['DoJ'],
        'additional': data['additional']
      };

      // {
      //   'userId': 'a002',
      //   'name': 'Prasad',
      //   'dept': 'CSE',
      //   'education': 'PhD',
      //   'DoJ': '03-2018',
      //   'additional': ' '
      // }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // var _values = {
  //   'userId': '',
  //   'name': '',
  //   'dept': '',
  //   'education': '',
  //   'DoJ': '',
  //   'additional': ' '
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          backgroundColor: Color(0xFFfff1e6),
          title: Text(
            'Edit Credentials',
            style: TextStyle(
              fontFamily: 'Prompt',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
                onPressed: _saveForm,
                icon: Icon(
                  Icons.save_outlined,
                  size: 35,
                ))
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFe8e8e4), Color(0xFFd8e2dc)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Text(
                          'UserId: ',
                          style: TextStyle(
                              fontFamily: 'Asap',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        //tileColor: Color(0xFF80ffdb),
                        title: Text(
                          '${_initValues['userId']}',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      ListTile(
                        leading: Text(
                          'Department: ',
                          style: TextStyle(
                              fontFamily: 'Asap',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          '${_initValues['dept']}',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: _initValues['name'],
                        decoration: InputDecoration(
                          fillColor: Color(0xFF073b4c),
                          focusColor: Color(0xFF073b4c),
                          hoverColor: Color(0xFF073b4c),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xFF0077b6))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF3f4238),
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.w500),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name cannot be null';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _initValues = {
                            'userId': _initValues['userId'],
                            'name': value,
                            'dept': _initValues['dept'],
                            'education': _initValues['education'],
                            'DoJ': _initValues['DoJ'],
                            'additional': _initValues['additional']
                          };
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: _initValues['education'],
                        decoration: InputDecoration(
                          fillColor: Color(0xFF073b4c),
                          focusColor: Color(0xFF073b4c),
                          hoverColor: Color(0xFF073b4c),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xFF0077b6))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          labelText: 'Education',
                          labelStyle: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF5a189a), //Color(0xFFf72585),
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.w500),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Education cannot be null';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _initValues = {
                            'userId': _initValues['userId'],
                            'name': _initValues['name'],
                            'dept': _initValues['dept'],
                            'education': value,
                            'DoJ': _initValues['DoJ'],
                            'additional': _initValues['additional']
                          };
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: _initValues['DoJ'],
                        decoration: InputDecoration(
                          fillColor: Color(0xFF073b4c),
                          focusColor: Color(0xFF073b4c),
                          hoverColor: Color(0xFF073b4c),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xFF0077b6))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'MM-YYYY',
                          hintStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.w400),
                          labelText: 'Date of Joining',
                          labelStyle: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF0b525b),
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.w500),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Date of Joining cannot be null';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.datetime,
                        onSaved: (value) {
                          _initValues = {
                            'userId': _initValues['userId'],
                            'name': _initValues['name'],
                            'dept': _initValues['dept'],
                            'education': _initValues['education'],
                            'DoJ': value,
                            'additional': _initValues['additional']
                          };
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
