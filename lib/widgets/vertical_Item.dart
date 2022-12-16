import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/vertical.dart';
import 'package:scrc/screens/vertical_detail_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../size_config.dart';

class VerticalItem extends StatefulWidget {
  @override
  _VerticalItemState createState() => _VerticalItemState();
}

class _VerticalItemState extends State<VerticalItem> {
  var readings = Map();
  Vertical vertical;
  bool _isLoading = false;
  bool _isInit = true;
  Future<void> fetchAvg(String name) async {
    var url = Uri.parse(
        "https://dashboard.smartcitylivinglab.iiit.ac.in/verticals/avg");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null) {
        extractedData.forEach((prodName, prodData) {
          if (prodName == name) {
            prodData.forEach((key, value) {
              // Double val = value as Double;
              // if (key != "nodes" && key != "name")
              //   readings[key] = value.toStringAsFixed(2);
              // if (key == "name") readings[key] = value;
              if (key != "nodes") readings[key] = value;
            });
          }
        });
      } else {
        readings["Error"] = "Error";
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      vertical = Provider.of<Vertical>(context, listen: false);
      fetchAvg(vertical.title).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> r = [];
    if (!_isLoading) {
      readings.forEach((key, value) {
        if (key != "name")
          r.add(Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.2,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: FittedBox(
                    child: Text(
                      key.toString().toUpperCase().replaceAll("_", " "),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
      });
    }
    return _isLoading
        ? Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Center(child: CircularProgressIndicator()),
            ))
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(VerticalDetailScreen.routeName,
                  arguments: [vertical.title, readings['name']]);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, bottom: 8, top: 16),
                            child: _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Text(
                                    readings['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: Colors.black),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 3),
                                    child: _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Text(
                                            vertical.vertices.length.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 32,
                                              color: Colors.blue,
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8),
                                    child: Text(
                                      'nodes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      width: getProportionateScreenHeight(100),
                                      height: getProportionateScreenHeight(100),
                                      margin: EdgeInsets.only(
                                        right: getProportionateScreenHeight(40),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/dashboard_icon/" +
                                                      vertical.title +
                                                      ".png"),
                                              fit: BoxFit.cover)),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: r,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
