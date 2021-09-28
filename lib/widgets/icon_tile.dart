import 'package:flutter/material.dart';

import '../size_config.dart';

typedef OnSelection();

class IconTile extends StatefulWidget {
  final double width;
  final double height;
  final String vertical;
  final ImageIcon icon;
  final OnSelection onSelection;
  const IconTile(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.vertical,
      @required this.onSelection,
      @required this.icon})
      : super(key: key);

  @override
  _IconTileState createState() => _IconTileState();
}

class _IconTileState extends State<IconTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: widget.onSelection,
          child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color(0xff645478),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: widget.icon),
            SizedBox(height: getProportionateScreenHeight(5)),
            FittedBox(
                child: Text(
              this.widget.vertical,
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
          ),
      ),
    );
  }
}
