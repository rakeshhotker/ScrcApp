import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrc/providers/vertex.dart';

import '../size_config.dart';

class VertexItem extends StatefulWidget {
  final int index;
  final Vertex vertex;
  VertexItem({this.vertex, this.index});

  @override
  _VertexItemState createState() => _VertexItemState();
}

class _VertexItemState extends State<VertexItem> {
  var readings = new Map();
  Future<void> getReadings() async {
    readings = widget.vertex.data;
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    getReadings();
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
              title: Text(widget.vertex.nodeId),
              subtitle: Text(widget.vertex.name),
              trailing: Container(
                width: getProportionateScreenWidth(100),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.graphic_eq_outlined),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                            _expanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
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
                            trailing: FittedBox(
                                child: Text(readings[key].toString())),
                          ),
                        ));
                  },
                ),
              )
          ],
        ));
  }
}
