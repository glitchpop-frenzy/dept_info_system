import 'package:flutter/material.dart';

import 'faculty_screen.dart';
import '../backend/server.dart' as server;
import 'auth_screen.dart';
import 'dept_home.dart';
import 'profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //bool _isLoading = true;
  //bool _isPage = false;
  bool _isAuth = false;
  List<Map<String, dynamic>> _pages;
  int _selectedPage = 0;
  String userId;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  BottomNavigationBarItem navButton3;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context).settings.arguments as List;
    _isAuth = args[0];
    userId = args[1];
    _pages = [
      {'page': DeptHome(), 'title': 'Departments'},
      {'page': FacultyScreen(), 'title': 'Faculty'},
      {'page': ProfileScreen(userId), 'title': 'Profile'}
    ];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage]['page'],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.11,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Color(0xFFd8e2dc)),
          child: BottomNavigationBar(
            //backgroundColor: Color(0xFF34a0a4),
            iconSize: 36.0,
            currentIndex: _selectedPage,
            onTap: _selectPage,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 18,
            selectedFontSize: 20,
            selectedLabelStyle: TextStyle(color: Colors.black),
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.apartment_sharp), label: 'Dept'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), label: 'Faculty'),
              // navButton3
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'Profile')
            ],
          ),
        ),
      ),
    );
  }
}
