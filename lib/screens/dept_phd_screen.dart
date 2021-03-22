import 'dart:convert';

import 'package:flutter/material.dart';
import '../providers/phd_list.dart';
import 'package:http/http.dart' as http;

class DeptPhdScreen extends StatefulWidget {
  static const routeName = 'dept-phd-screen';
  @override
  _DeptPhdScreenState createState() => _DeptPhdScreenState();
}

class _DeptPhdScreenState extends State<DeptPhdScreen> {
  String title;
  int color;
  bool _isInit = true;
  bool _isLoading = true;

  List<Phd> dataList = [];
  Future<void> getPhd() async {
    String url = 'http://localhost:3000/department/phd?dept=$title';
    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);
    dataList = PhdList.fromJson(jsonResponse['list']).phdList;
    //print(dataList);
  }

  @override
  void didChangeDependencies() async {
    List args = ModalRoute.of(context).settings.arguments as List;
    title = args[0];
    color = args[1];
    await getPhd();
    setState(() {
      _isLoading = false;
    });
    _isInit = false;
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
          title: Text('$title / PhD Students',
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
    ;
  }
}
