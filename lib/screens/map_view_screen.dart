import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:animated_stack/animated_stack.dart';
import 'package:scrc/widgets/data_container.dart';
import 'package:scrc/widgets/icon_tile.dart';
import '../providers/vertex.dart';
import '../size_config.dart';

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
  BitmapDescriptor wnIcon;
  String selected = "all";

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    setCustomMapPin().then((value) {
      _getLoc();
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final verticalsData = Provider.of<Verticals>(context);
    final verticals = verticalsData.items;
    // debugPrint(verticals)
    if (!_loading) {
      for (int i = 0; i < verticals.length; i++) {
        if (selected == verticals[i].title || selected == "all")
          for (int j = 0; j < verticals[i].vertices.length; j++) {
            Vertex vertex = verticals[i].vertices[j];
            _markers.add(Marker(
              markerId: MarkerId(vertex.data['node_id']),
              position:
                  LatLng(vertex.data['latitude'], vertex.data['longitude']),
              infoWindow: InfoWindow(
                title: verticals[i].title,
                snippet: vertex.data['node_id'],
              ),
              draggable: true,
              icon: getIcon(vertex),
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    isDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return DataContainer(vertex: vertex);
                    });
              },
            ));
          }
      }
    }
    return Scaffold(
      drawer: MyDrawer(),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : AnimatedStack(
              backgroundColor: Color(0xff321B4A),
              fabBackgroundColor: Color(0xffEB456F),
              buttonIcon: Icons.menu,
              foregroundWidget: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 17.0,
                ),
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(_markers),
              ),
              columnWidget: Container(
                height: getProportionateScreenHeight(650),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: verticals.length,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(20)),
                        IconTile(
                          width: getProportionateScreenWidth(60),
                          height: getProportionateScreenHeight(70),
                          vertical: verticals[i].title,
                          onSelection: () => onSelection(verticals[i].title),
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icon/" + verticals[i].title + ".png"),
                            color: Color.fromARGB(255, 245, 240, 240),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              bottomWidget: GestureDetector(
                onTap: () => onSelection("all"),
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenHeight(15)),
                  child: Text(
                    "Show All",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff645478),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  width: getProportionateScreenHeight(260),
                  height: getProportionateScreenHeight(50),
                ),
              ),
            ),
    );
  }

  void onSelection(String _selection) {
    print(_selection);
    setState(() {
      _markers.clear();
      selected = _selection;
    });
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
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sr_aq.png');
    sremIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sr_em.png');
    srocIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sr_oc.png');
    weIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/we.png');
    wdIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/wd.png');
    wfIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/wf.png');
    wnIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/sl.png');
  }

  BitmapDescriptor getIcon(Vertex vertex) {
    print(vertex.type);
    BitmapDescriptor icon = vertex.type == "aq"
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
                                    : (vertex.type == "sr_oc"
                                        ? srocIcon
                                        : (vertex.type == "sl"
                                            ? slIcon
                                            : (vertex.type == "s"
                                                ? sIcon
                                                : (vertex.type == "em"
                                                    ? emIcon
                                                    : (vertex.type == "wn"
                                                        ? wnIcon
                                                        : BitmapDescriptor
                                                            .defaultMarker))))))))))));
    return icon;
  }
}
