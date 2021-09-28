import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrc/providers/vertex.dart';

import '../size_config.dart';

class DataContainer extends StatelessWidget {
  final Vertex vertex;
  DataContainer({this.vertex});

  
  @override
  Widget build(BuildContext context) {
    return Container(
                        padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                        height: min(
                            (80 * vertex.data.length + 10).ceilToDouble(),
                            300),
                        child: ListView.builder(
                          itemCount: vertex.data.length,
                          itemBuilder: (_, i) {
                            String key = vertex.data.keys.elementAt(i);
                            if (key == "Timestamp" ||
                                key == "observationDateTime") {
                              DateTime dt = new DateFormat("yyyy-MM-dd")
                                  .parse(vertex.data[key]);
                              vertex.data[key] =
                                  dt.toString().substring(0, 10);
                            }
                            return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        getProportionateScreenWidth(4),
                                    horizontal:
                                        getProportionateScreenHeight(15)),
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
                                            style: TextStyle(
                                                color: Colors.black),
                                          ))),
                                    ),
                                    title: Text(key.replaceAll("_", " ").toUpperCase()),
                                    trailing: FittedBox(
                                        child: Text(
                                            vertex.data[key].toString())),
                                  ),
                                )
                              );
                          },
                        ),
                      );
  }
}
