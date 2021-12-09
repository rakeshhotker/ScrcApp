import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/graph_data.dart';
import 'package:scrc/providers/verticals.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class GraphScreen extends StatefulWidget {
  static const routeName = '/verticals/detail/graph';
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  var _isInit = true;
  var _isloading = false;
  var node;
  String nodeId;
  var type;
  var verticalsData;
  var graph;
  DateTime rangeStartDate =
      DateTime.now().subtract(Duration(hours: 3));
  DateTime rangeEndDate = DateTime.now();

  Future<void> getGraphReadings() async {
    String url = "https://smartcitylivinglab.iiit.ac.in/graph/?start=";
    url += rangeStartDate.toIso8601String();
    url += "&end=";
    url += rangeEndDate.toIso8601String();
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
      getGraphReadings().then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePinching: true,
      enableSelectionZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isloading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      Map<String, List<double>> data = Map();
      List<String> dates = [];
      graph.forEach((key, value) {
        if (key != "parameters" && key != "nodes")
          (value as List).forEach((element) {
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
                data[ke.toString()].add((val != null) ? val : 0.0);
              } else {
                if (ke == "created_at") {
                  dates.add(val);
                }
              }
            });
          });
      });
      List<String> names = [];
      List<List<GraphData>> lines = [];
      data.forEach((key, value) {
        names.add(key);
        List<GraphData> tmp = [];
        for (int i = 0; i < value.length; i++) {
          tmp.add(GraphData(
            value: value[i],
            year: DateFormat('dd MMM yyyy \n kk:mm').format(DateTime.parse(dates[i])) ,
          ));
        }
        lines.add(tmp);
      });

      return Scaffold(
          appBar: AppBar(
            title: Text(nodeId),
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Color(0XFF8B8B8B), fontSize: 18
            ),
            elevation: 5,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Starting date'),
                          content: SingleChildScrollView(
                            child: SfDateRangePicker(
                              view: DateRangePickerView.month,
                              selectionMode:
                                  DateRangePickerSelectionMode.range,
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs
                                      args) {
                                if (args.value is PickerDateRange) {
                                  rangeStartDate = args.value.startDate;
                                  rangeEndDate = args.value.endDate;
                                }
                              },
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Done'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _isloading = true;
                                });
                                getGraphReadings().then((value) {
                                  setState(() {
                                    _isloading = false;
                                  });
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Pick Dates"),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: SfCartesianChart(
                        zoomPanBehavior: _zoomPanBehavior,
                        primaryXAxis: CategoryAxis(
                          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        ),
                        enableAxisAnimation: true,
                        legend: Legend(isVisible: true),
                        series: <CartesianSeries>[
                          for (int i = 0; i < lines.length; i++)
                            LineSeries<GraphData, String>(
                                name: names[i],
                                dataSource: lines[i],
                                xValueMapper: (GraphData data, _) =>
                                    data.year,
                                yValueMapper: (GraphData data, _) =>
                                    data.value,
                            )
                        ]),
                  ),
                ),
              ],
            ),
          ));
    }
  }
}


