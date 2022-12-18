import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:scrc/screens/about.dart';
import 'package:scrc/screens/summary_detail_screen.dart';

import '../screens/map_view_screen.dart';
import '../screens/verticals_overview_screen.dart';
import '../size_config.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: Column(children: [
        AppBar(
            title: Text("Welcome"),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Color(0XFF8B8B8B),
              fontSize: 18,
            ),
            elevation: 5,
            iconTheme: IconThemeData(color: Colors.black)),
        Container(
          width: getProportionateScreenWidth(250),
          height: getProportionateScreenHeight(120),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icon/smartCity_livingLab.png"),
                  fit: BoxFit.contain)),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Verticals"),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(VerticalsOverviewScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.location_pin),
          title: Text("Map View"),
          onTap: () async {
            Location location = new Location();

            bool _serviceEnabled;
            _serviceEnabled = await location.serviceEnabled();
            if (!_serviceEnabled) {
              _serviceEnabled = await location.requestService();
              if (!_serviceEnabled) {
                return;
              }
            }
            Navigator.of(context).pushReplacementNamed(MapViewScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Summary"),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(SummaryDetailScreen.routeName);
          },
        ),

        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("About"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AboutScreen.routeName);
          },
        ),
        Divider(),
        // ListTile(
        //   leading: Icon(Icons.shop),
        //   title: Text("License"),
        //   onTap: () {
        //     Navigator.of(context)
        //         .pushReplacementNamed(VerticalsOverviewScreen.routeName);
        //   },
        // ),
      ]),
    );
  }
}
