import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/map_view_screen.dart';
import './providers/verticals.dart';
import './screens/vertical_detail_screen.dart';
import './screens/verticals_overview_screen.dart';
import './theme.dart';
import 'screens/graph_screen.dart';

void main() { 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white
    ));
    return MultiProvider(                                                                     
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Verticals(),
          ),
        ],
        child: MaterialApp(
          title: 'SCRC Lab',
          theme: theme(),
          home: VerticalsOverviewScreen(),
          routes: {
            VerticalsOverviewScreen.routeName: (ctx) => VerticalsOverviewScreen(), 
            VerticalDetailScreen.routeName: (ctx) => VerticalDetailScreen(),
            GraphScreen.routeName: (ctx) => GraphScreen(),
            MapViewScreen.routeName: (ctx) => MapViewScreen(),
          },
        )
    );
  }
}
