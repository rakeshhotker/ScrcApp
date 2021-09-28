import 'package:flutter/material.dart';
import 'package:scrc/providers/vertex.dart';
import 'package:scrc/screens/graph_screen.dart';
import 'package:scrc/widgets/data_container.dart';

import '../size_config.dart';

class VertexItem extends StatefulWidget {
  final int index;
  final Vertex vertex;
  VertexItem({this.vertex, this.index});

  @override
  _VertexItemState createState() => _VertexItemState();
}

class _VertexItemState extends State<VertexItem> {
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
              title: Text(widget.vertex.nodeId),
              subtitle: Text(widget.vertex.name),
              trailing: Container(
                width: getProportionateScreenWidth(100),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.graphic_eq_outlined),
                        onPressed: () {``
                          Navigator.of(context).pushNamed(GraphScreen.routeName, arguments: [widget.vertex.nodeId, widget.vertex.type]);
                        }),
                    IconButton(
                        icon: Icon(
                            _expanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                          });
                        }),
                  ],
                ),
              ),
            ),
            if (_expanded)
              DataContainer(vertex: widget.vertex)
          ],
        ));
  }
}
