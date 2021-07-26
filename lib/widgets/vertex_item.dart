import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:scrc/size_config.dart';

class VertexItem extends StatefulWidget {
  final String name;
  final String env;
  final int index;
  VertexItem({this.name, this.env, this.index});

  @override
  _VertexItemState createState() => _VertexItemState();
}

class _VertexItemState extends State<VertexItem> {
  var readings = new Map();
  Future<void> getReadings() async {
    String url =
        "https://iudx-rs-onem2m.iiit.ac.in/ngsi-ld/v1/entities/research.iiit.ac.in/f7cc38aec6ba595e699add1601d2967c7b13b489/iudx-rs-onem2m.iiit.ac.in/iiith-env-";
    url += widget.env + "/" + widget.name;
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      String status = extractedData['title'];
      if (status == "success") {
        final re = extractedData['results'] as List<dynamic>;
        re.forEach((results) {
          results.forEach((key, value) {
            if (key != "versionInfo" && key != "id") {
              if (key == "Timestamp" ||
                  key == "observationDateTime" ||
                  key == "airQualityIndex" ||
                  key == "airQualityLevel" ||
                  key == "aqiMajorPollutant") {
                readings[key] = value.toString();
              } else {
                final data = value as Map<String, dynamic>;
                readings[key] = data["instValue"].toString();
              }
            }
          });
        });
        
        print("Yes");
      } else {
        readings['Error'] = 'Invalid Name/Env';
      }
    } catch (error) {
      readings['Error'] = 'Invalid Name/Env';
      print(error);
    }
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(child: Text(widget.index.toString()))),
              ),
              title: Text(widget.name),
              trailing: Container(
                width: getProportionateScreenWidth(100),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.graphic_eq_outlined),
                        onPressed: () {
                          
                        }),
                    IconButton(
                        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          if (!_expanded)
                            getReadings().then((value) => {
                                  setState(() {
                                    _expanded = !_expanded;
                                  })
                                });
                          else
                            setState(() {
                              readings.clear();
                              _expanded = !_expanded;
                            });
                        }),
                  ],
                ),
              ),
            ),
            if (_expanded)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: min((80 * readings.length + 10).ceilToDouble(), 300),
                child: ListView.builder(
                  itemCount: readings.length,
                  itemBuilder: (_, i) {
                    String key = readings.keys.elementAt(i);
                    if (key == "Timestamp" || key == "observationDateTime") {
                      DateTime dt =
                          new DateFormat("yyyy-MM-dd").parse(readings[key]);
                      readings[key] = dt.toString().substring(0, 10);
                    }
                    return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.cyan,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: FittedBox(
                                      child: Text(
                                    (i + 1).toString(),
                                    style: TextStyle(color: Colors.black),
                                  ))),
                            ),
                            title: Text(key),
                            trailing: FittedBox(child: Text(readings[key])),
                          ),
                        ));
                  },
                ),
              )
          ],
        ));
  }
}
