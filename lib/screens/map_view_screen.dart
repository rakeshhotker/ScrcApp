import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:math';

import '../providers/verticals.dart';
import '../widgets/main_drawer.dart';

class MapViewScreen extends StatefulWidget {
  static const routeName = "/mapView";
  @override
  _MapViewScreenState createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  var readings = new Map();
  Future<void> getReadings(String env, String name) async {
    String url =
        "https://iudx-rs-onem2m.iiit.ac.in/ngsi-ld/v1/entities/research.iiit.ac.in/f7cc38aec6ba595e699add1601d2967c7b13b489/iudx-rs-onem2m.iiit.ac.in/iiith-env-";
    url += env + "/" + name;
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      String status = extractedData['title'];
      if (status == "success") {
        final re = extractedData['results'] as List<dynamic>;
        re.forEach((results) {
          results.forEach((key, value) {
            if(key != "versionInfo" && key != "id") {
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
      } else {
        readings['Error'] = 'Invalid Name/Env';
      }
    } catch (error) {
      readings['Error'] = 'Invalid Name/Env';
      print(error);
    }
  }

  GoogleMapController mapController;
  Location location = new Location();
  bool _loading;
  LatLng _center;
  List<Marker> _markers = <Marker>[];
  _getLoc() async {
    _center = new LatLng(17.445842363432902, 78.34941146641764);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    _getLoc();
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final verticalsData = Provider.of<Verticals>(context);
    final verticals = verticalsData.items;
    verticals.forEach((vertical) {
      vertical.vertices.forEach((vertex) {
        _markers.add(Marker(
          markerId: MarkerId(vertex.name),
          position: LatLng(
              double.parse(vertex.latitude), double.parse(vertex.longitude)),
          infoWindow: InfoWindow(
            title: vertical.title,
            snippet: vertex.name,
          ),
          onTap: () {
            readings.clear();
            getReadings(vertical.env, vertex.name).whenComplete(() => {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Card(
                            margin: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: min(
                                  (80 * readings.length + 10).ceilToDouble(),
                                  300),
                              child: ListView.builder(
                                itemCount: readings.length,
                                itemBuilder: (_, i) {
                                  String key = readings.keys.elementAt(i);
                                  if (key == "Timestamp" ||
                                      key == "observationDateTime") {
                                    DateTime dt = new DateFormat("yyyy-MM-dd")
                                        .parse(readings[key]);
                                    readings[key] =
                                        dt.toString().substring(0, 10);
                                  }
                                  return Card(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
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
                                          title: Text(key),
                                          trailing: FittedBox(
                                              child: Text(readings[key])),
                                        ),
                                      ));
                                },
                              ),
                            ));
                      })
                });
          },
        ));
      });
    });
    return Scaffold(
      drawer: MyDrawer(),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 17.0,
              ),
              markers: Set<Marker>.of(_markers),
            ),
    );
  }
}
