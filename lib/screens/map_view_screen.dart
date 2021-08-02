import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import '../providers/vertex.dart';
import '../size_config.dart';
import 'dart:math';

import '../providers/verticals.dart';
import '../widgets/main_drawer.dart';

class MapViewScreen extends StatefulWidget {
  static const routeName = "/mapView";
  @override
  _MapViewScreenState createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController mapController;
  Location location = new Location();
  bool _loading;
  LatLng _center;
  List<Marker> _markers = <Marker>[];
  BitmapDescriptor aqIcon;
  BitmapDescriptor wdIcon;
  BitmapDescriptor wfIcon;
  BitmapDescriptor slIcon;
  BitmapDescriptor cmIcon;
  BitmapDescriptor sracIcon;
  BitmapDescriptor sraqIcon;
  BitmapDescriptor sremIcon;
  BitmapDescriptor sIcon;
  BitmapDescriptor weIcon;
  BitmapDescriptor srocIcon;
  BitmapDescriptor emIcon;

  _getLoc() async {
    _center = new LatLng(17.445842363432902, 78.34941146641764);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    setCustomMapPin().then((value) {
      _getLoc();
    });
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
    if (!_loading)
      verticals.forEach((vertical) {
        vertical.vertices.forEach((vertex) {
          _markers.add(Marker(
            markerId: MarkerId(vertex.data['name']),
            position: LatLng(vertex.data['latitude'], vertex.data['longitude']),
            infoWindow: InfoWindow(
              title: vertical.title,
              snippet: vertex.data['node_id'],
            ),
            icon: vertex.type == "aq"
                ? aqIcon
                : (vertex.type == "cm"
                    ? cmIcon
                    : (vertex.type == "wd"
                        ? wdIcon
                        : (vertex.type == "wf"
                            ? wfIcon
                            : (vertex.type == "we"
                                ? weIcon
                                : (vertex.type == "sr_ac"
                                    ? sracIcon
                                    : (vertex.type == "sr_aq"
                                        ? sraqIcon
                                        : (vertex.type == "sr_em"
                                            ? sremIcon
                                            : (vertex.type == "sroc_result"
                                                ? srocIcon
                                                : (vertex.type == "sl"
                                                    ? slIcon
                                                    : (vertex.type == "s"
                                                        ? sIcon
                                                        : (vertex.type == "em"
                                                            ? emIcon
                                                            : BitmapDescriptor
                                                                .defaultMarker))))))))))),
            onTap: () {
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
                                      vertical: getProportionateScreenWidth(4), horizontal: getProportionateScreenHeight(15)),
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
                                          child: Text(
                                              vertex.data[key].toString())),
                                    ),
                                  ));
                            },
                          ),
                        ));
                  });
            },
          ));
        });
      });

    return Scaffold(
      drawer: MyDrawer(),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 17.0,
                  ),
                  markers: Set<Marker>.of(_markers),
                ),
              ],
            ),
    );
  }

  Future<void> setCustomMapPin() async {
    aqIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.05), "assets/icon/aq.png");
    cmIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/cm.png');
    emIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/em.png');
    sIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/s.png');
    slIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sl.png');
    sracIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sr_ac.png');
    sraqIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sr_aq.png.png');
    sremIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sr_em.png');
    srocIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/sroc_result.png');
    weIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/we.png');
    wdIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/wd.png');
    wfIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/wf.png');
  }
}
