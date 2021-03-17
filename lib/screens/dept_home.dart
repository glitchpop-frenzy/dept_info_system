//import '/dept_data.dart';
import '../models/dept_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/dept_item.dart';

//import '../widgets/appBar.dart';
//import '../models/dept_catg.dart';

class DeptHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          leading: Icon(
            Icons.apartment_sharp,
            size: 30,
          ),
          title: Text('Departments'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFf8edeb), Color(0xFFcaf0f8)]),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF7180ac),
              Color(0xFFffe8d6)
            ], //bde0fe //263c41 //e01e37  aeb4a9
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: GridView(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 5 / 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          children: deptData.map((dept) {
            return DeptItem(dept.title, dept.color);
          }).toList(),
        ),
      ),
    );
  }
}
