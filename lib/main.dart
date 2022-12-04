import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/map_view_screen.dart';
import './providers/verticals.dart';
import './screens/vertical_detail_screen.dart';
import './screens/verticals_overview_screen.dart';
import './theme.dart';
import 'screens/graph_screen.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scrc/screens/about.dart';
// import 'package:workmanager/workmanager.dart';
import './screens/map_view_screen.dart';
// import './screens/auth_screen.dart';
// import './screens/edit_vertical_screen.dart';
// import './screens/user_vertical_screen.dart';
import './providers/verticals.dart';
import './providers/summary.dart';
import './screens/vertical_detail_screen.dart';
import './screens/summary_detail_screen.dart';
import './screens/verticals_overview_screen.dart';
import './theme.dart';
// import 'package:home_widget/home_widget.dart';



// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) {
//     final now = DateTime.now();
//     return Future.wait<bool>([
//       HomeWidget.saveWidgetData(
//         'title',
//         'Updated from Background',
//       ),
//       HomeWidget.saveWidgetData(
//         'message',
//         '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
//       ),
//       HomeWidget.updateWidget(
//         name: 'HomeWidgetExampleProvider',
//         iOSName: 'HomeWidgetExample',
//       ),
//     ]).then((value) {
//       return !value.contains(false);
//     });
//   });
// }

/// Called when Doing Background Work initiated from Widget
// void backgroundCallback(Uri data) async {
//   print(data);

//   if (data.host == 'titleclicked') {
//     final greetings = [
//       'Hello',
//       'Hallo',
//       'Bonjour',
//       'Hola',
//       'Ciao',
//       '哈洛',
//       '안녕하세요',
//       'xin chào'
//     ];
//     final selectedGreeting = greetings[Random().nextInt(greetings.length)];

//     await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
//     await HomeWidget.updateWidget(
//         name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
//   }
// }



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  // static const routeName = "/about";
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    // HomeWidget.registerBackgroundCallback(backgroundCallback);

    // _startBackgroundUpdate();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _checkForWidgetLaunch();
  //   // HomeWidget.widgetClicked.listen(_launchedFromWidget);
  // }

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _messageController.dispose();
  //   super.dispose();
  // }

  // Future<void> _sendData() async {
  //   try {
  //     return Future.wait([
  //       HomeWidget.saveWidgetData<String>('title', _titleController.text),
  //       HomeWidget.saveWidgetData<String>('message', _messageController.text),
  //     ]);
  //   } on PlatformException catch (exception) {
  //     debugPrint('Error Sending Data. $exception');
  //   }
  // }

  // Future<void> _updateWidget() async {
  //   try {
  //     return HomeWidget.updateWidget(
  //         name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
  //   } on PlatformException catch (exception) {
  //     debugPrint('Error Updating Widget. $exception');
  //   }
  // }

  // Future<void> _loadData() async {
  //   try {
  //     return Future.wait([
  //       HomeWidget.getWidgetData<String>('title', defaultValue: 'Default Title')
  //           .then((value) => _titleController.text = value),
  //       HomeWidget.getWidgetData<String>('message',
  //               defaultValue: 'Default Message')
  //           .then((value) => _messageController.text = value),
  //     ]);
  //   } on PlatformException catch (exception) {
  //     debugPrint('Error Getting Data. $exception');
  //   }
  // }

  // Future<void> _sendAndUpdate() async {
  //   await _sendData();
  //   await _updateWidget();
  // }

  // void _checkForWidgetLaunch() {
  //   HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  // }

  // void _launchedFromWidget(Uri uri) {
  //   if (uri != null) {
  //     showDialog(
  //         context: context,
  //         builder: (buildContext) => AlertDialog(
  //               title: Text('App started from HomeScreenWidget'),
  //               content: Text('Here is the URI: $uri'),
  //             ));
  //   }
  // }

  // void _startBackgroundUpdate() {
  //   Workmanager().registerPeriodicTask('1', 'widgetBackgroundUpdate',
  //       frequency: Duration(minutes: 15));
  // }

  // void _stopBackgroundUpdate() {
  //   Workmanager().cancelByUniqueName('1');
  // }



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white, systemNavigationBarColor: Colors.white));
    
    
      // _titleController.text = "Title";
      // _messageController.text = "Message";
      // _sendAndUpdate();
 return MultiProvider(                                                                     
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Verticals(),
            
          ),
          ChangeNotifierProvider(
            create: (ctx) => Summaries(),
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
            SummaryDetailScreen.routeName: (ctx) => SummaryDetailScreen(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            MapViewScreen.routeName: (ctx) => MapViewScreen(),
          },
        )
    );
  }
}

