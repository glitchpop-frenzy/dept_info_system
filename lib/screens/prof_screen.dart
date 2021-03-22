import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../providers/prof_list.dart';

class ProfScreen extends StatefulWidget {
  static const routeName = 'prof-screen';

  @override
  _ProfScreenState createState() => _ProfScreenState();
}

class _ProfScreenState extends State<ProfScreen> {
  bool _isLoading = true;
  bool _isInit = true;

  List<Prof> dataList = [];
  Future<void> getProf() async {
    final url = 'http://localhost:3000/listPage/prof';
    final response = await http.get(url);

    final jsonResponse = json.decode(response.body.toString());
    dataList = ProfList.fromJson(jsonResponse['list']).profList;
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await getProf();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final profData = Provider.of<ProfList>(context);
    //final list = profData.list;
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
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
    final args = ModalRoute.of(context).settings.arguments as List;
    final title = args[0];
    final color = args[1];

    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          title: Text(title),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                fieldInfo('userId ', dataList[index].userId),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  (dataList[index].additional == null)
                                      ? ''
                                      : '${dataList[index].additional}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
