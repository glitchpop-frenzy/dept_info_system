import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/resources_list.dart';

class ResourcesScreen extends StatefulWidget {
  static const routeName = 'rsc-screen';

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  bool _isLoading = true;
  bool _isInit = true;

  List<Resources> dataList = [];
  Future<void> getResources() async {
    final url = 'http://localhost:3000/listPage/resources';
    final response = await http.get(url);

    final jsonResponse = json.decode(response.body.toString());
    dataList = ResourcesList.fromJson(jsonResponse['list']).resourcesList;
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await getResources();
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
      return Row(children: [
        Text(
          '$field: ',
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          fac == 'N/A' ? 'N/A' : '$fac',
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  'Place: ',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  '${dataList[index].id}',
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            fieldInfo(
                                'Lab Assistant ',
                                dataList[index].labAss.isEmpty
                                    ? 'N/A'
                                    : dataList[index].labAss),
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
                                            'Type ',
                                            dataList[index].type.isEmpty
                                                ? 'N/A'
                                                : dataList[index].type == null
                                                    ? null
                                                    : dataList[index].type)),
                                  )
                                ]),
                            SizedBox(
                              height: 8,
                            ),
                            fieldInfo('Capacity ',
                                (dataList[index].capacity).toStringAsFixed(0))
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
