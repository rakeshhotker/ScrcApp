import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/widgets/summary_details.dart';

import '../providers/verticals.dart';
import '../widgets/main_drawer.dart';
import '../widgets/verticals_grid.dart';

class SummaryDetailScreen extends StatefulWidget {
  static const routeName = "/summary";
  @override
  _SummaryDetailScreenState createState() => _SummaryDetailScreenState();
}

class _SummaryDetailScreenState extends State<SummaryDetailScreen> {
  var _isInit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Summaries>(context).fetchAndSetSummary().then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            // appBar: AppBar(
            //   title: Text("Verticals"),
            // ),
            // drawer: MyDrawer(),
            body: Center(
                child: Image.asset("assets/icon/smartCity_livingLab.png")),
            // body: _isloading ? Center(child: CircularProgressIndicator()) : VerticalsGrid(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Summary", style: TextStyle(color: Colors.black)),
            ),
            drawer: MyDrawer(),
            body: Center(
              child: SummaryDetails(),
              // body: _isloading ? Center(child: CircularProgressIndicator()) : VerticalsGrid(),
            ));
  }
}
