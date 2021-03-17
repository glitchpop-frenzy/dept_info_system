import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../providers/aprof_list.dart';

class DeptAprofScreen extends StatefulWidget {
  static const routeName = 'dept-aprof-screen';
  @override
  _DeptAprofScreenState createState() => _DeptAprofScreenState();
}

class _DeptAprofScreenState extends State<DeptAprofScreen> {
  List<Aprof> dataList = [];

  Future<void> getAprof() async {
    final url = 'http://localhost:3000/department/Aprof?dept=$title';
    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);
    dataList = AprofList.fromJson(jsonResponse['list']).aprofList;
  }

  bool _isInit = true;
  bool _isLoading = true;
  String title;
  int color;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      List args = ModalRoute.of(context).settings.arguments as List;
      title = args[0];
      color = args[1];
      await getAprof();
      setState(() {
        _isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int num = 0;

    List<Color> grad() {
      num += 1;
      if (num % 2 == 0) {
        return [Color(0xFFdcd6f7), Color(0xFFa1fcdf)];
      } else {
        return [Color(0xFFfbc3bc), Color(0xFFfbc3bc)];
      }
    }

    Widget fieldInfo(String field, String fac) {
      return Row(children: [
        Text(
          '$field: ',
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          '$fac',
          // textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.headline5,
        ),
      ]);
    }

    final mediaquery = MediaQuery.of(context);
    //final title = ModalRoute.of(context).settings.arguments as List;

    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          title: Text('$title / Assistant Professors',
              style: TextStyle(color: Color(0xFFecf8f8))),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Color(color),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                  height: mediaquery.size.height * 0.25,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  width: double.infinity,
                  child: Card(
                    //color: Color(0xFF468faf),
                    elevation: 2.6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: grad()),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  'userId: ',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  '${dataList[index].userId}',
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            fieldInfo('Name ', dataList[index].name),
                            SizedBox(
                              height: 8,
                            ),
                            //fieldInfo('Date of Joining ', profList[index].doj),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  fieldInfo('Dept', dataList[index].dept),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Flexible(
                                    child: FittedBox(
                                      child: fieldInfo(
                                          'DoJ ', dataList[index].DoJ),
                                    ),
                                  )
                                ]),
                            SizedBox(
                              height: 8,
                            ),
                            fieldInfo('Education', dataList[index].education)
                          ]),
                    ),
                  ),
                );
              },
              itemCount: dataList.length,
            ),
    );
    return scaffold;
  }
}
