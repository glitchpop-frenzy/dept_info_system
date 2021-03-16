import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/aprof_list.dart';
import '../providers/aprof_list.dart';
import 'package:http/http.dart' as http;

class AprofScreen extends StatefulWidget {
  static const routeName = 'aprof-screen';

  @override
  _AprofScreenState createState() => _AprofScreenState();
}

class _AprofScreenState extends State<AprofScreen> {
  bool _isLoading = true;
  bool _isInit = true;

  List<Aprof> dataList = [];
  Future<void> getAprof() async {
    final url = 'http://localhost:3000/listPage/Aprof';
    final response = await http.get(url);

    final jsonResponse = json.decode(response.body.toString());
    dataList = AprofList.fromJson(jsonResponse['list']).list;
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await getAprof();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context).settings.arguments as String;
    int num = 0;
    final mediaquery = MediaQuery.of(context);

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
          style: Theme.of(context).textTheme.headline5,
        ),
      ]);
    }

    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text(title),
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
