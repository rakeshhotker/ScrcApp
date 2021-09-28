import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/verticals.dart';
import 'package:http/http.dart' as http;

class GraphScreen extends StatefulWidget {
  static const routeName = '/verticals/detail/graph';
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  var _isInit = true;
  var _isloading = false;
  var node;
  var nodeId;
  var type;
  var verticalsData;
  var graph;
  var len;
  var start =
      DateTime.now().subtract(Duration(days: 3, hours: 3)).toIso8601String();
  Map<String, List<DataPoint<double>>> data;

  Future<void> getGraphReadings() async {
    final end = DateTime.now().subtract(Duration(days: 3)).toIso8601String();
    String url = "https://smartcitylivinglab.iiit.ac.in/graph/?start=";
    url += start;
    url += "&end=";
    url += end;
    url += "&type=";
    url += type.toUpperCase().replaceAll("_", "-");
    url += "&nodes=";
    url += nodeId;
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      graph = extractedData;
      // print(graph.toString());
    } catch (error) {
      print(error);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      node = ModalRoute.of(context).settings.arguments as List;
      nodeId = node[0];
      type = node[1];
      verticalsData = Provider.of<Verticals>(context);
      len = 0;
      data = Map();
      getGraphReadings().then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isloading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      graph.forEach((key, value) {
        (value as List).forEach((element) {
          len++;
          double k = 0;
          element.forEach((ke, val) {
            if (ke != "node_id" &&
                ke != "name" &&
                ke != "latitude" &&
                ke != "longitude" &&
                ke != "type" &&
                ke != "created_at" &&
                ke != "occupancy1" &&
                ke != "occupancy2" &&
                ke != "occupancy3" &&
                ke != "occupancy4") {
              if (data[ke] == null) {
                data[ke] = [];
              }
              data[ke.toString()].add(DataPoint<double>(
                  value: (val != null) ? val : 0.0, xAxis: k));
              k += 1;
            }
          });
        });
      });
      List<BezierLine> plots = [];
      if (data.length > 0)
        data.forEach((key, value) {
          plots.add(BezierLine(
            lineColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
            label: key.toUpperCase().replaceAll("_", " "),
            lineStrokeWidth: 2.0,
            data: value,
          ));
        });
      else
        plots.add(BezierLine(
          lineColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          label: "",
          lineStrokeWidth: 2.0,
          data: [
            DataPoint<double>(value: 0.0, xAxis: 0),
          ],
        ));
      List<double> x = [];
      if (len > 0)
        for (int i = 0; i < len; i++) {
          x.add(i.toDouble());
        }
      else
        x.add(0);
      return Scaffold(
          appBar: AppBar(title: Text(nodeId)),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isloading = true;
                        });
                        start = DateTime.now()
                            .subtract(Duration(days: 365))
                            .toIso8601String();
                        getGraphReadings().then((value) {
                          setState(() {
                            _isloading = false;
                          });
                        });
                      },
                      child: Text("Last Year"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isloading = true;
                        });
                        start = DateTime.now()
                            .subtract(Duration(days: 30))
                            .toIso8601String();
                        getGraphReadings().then((value) {
                          setState(() {
                            _isloading = false;
                          });
                        });
                      },
                      child: Text("Last month"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isloading = true;
                        });
                        start = DateTime.now()
                            .subtract(Duration(days: 7))
                            .toIso8601String();
                        getGraphReadings().then((value) {
                          setState(() {
                            _isloading = false;
                          });
                        });
                      },
                      child: Text("Last week"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isloading = true;
                        });
                        start = DateTime.now()
                            .subtract(Duration(days: 1))
                            .toIso8601String();
                        getGraphReadings().then((value) {
                          setState(() {
                            _isloading = false;
                          });
                        });
                      },
                      child: Text("Last Day"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isloading = true;
                        });
                        start = DateTime.now()
                            .subtract(Duration(hours: 3))
                            .toIso8601String();
                        getGraphReadings().then((value) {
                          setState(() {
                            _isloading = false;
                          });
                        });
                      },
                      child: Text("Last 3 hours"),
                    ),
                  ],
                ),
                Center(
                  child: Card(
                    elevation: 20,
                    margin: EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: BezierChart(
                        bezierChartScale: BezierChartScale.CUSTOM,
                        xAxisCustomValues: x,
                        footerValueBuilder: (double value) {
                          return "";
                        },
                        series: plots,
                        config: BezierChartConfig(
                          verticalIndicatorStrokeWidth: 2.0,
                          verticalIndicatorColor: Colors.black12,
                          showVerticalIndicator: true,
                          bubbleIndicatorLabelStyle:
                              const TextStyle(fontWeight: FontWeight.normal,),
                          bubbleIndicatorTitleStyle:
                              const TextStyle(color: Colors.white),
                          verticalIndicatorFixedPosition: true,
                          contentWidth:
                              MediaQuery.of(context).size.width * (len / 5),
                          snap: false,
                          backgroundColor: Colors.white,
                          displayLinesXAxis: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    }
  }
}
