import 'package:flutter/material.dart';
import 'package:scrc/widgets/main_drawer.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = "/about";
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
        appBar: AppBar(
          title: Text("About", style: TextStyle(color: Colors.black)),
        ),
        drawer: MyDrawer(),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset("assets/dashboard_icon/group_photo.jpg"),
                SizedBox(height: 20),
                Text(
                    "The primary goal of this innovation initiative is to enable discovering, sourcing, validating, proving and taking to production, the various Smart City innovations, solutions and products.And also bringing in the key stakeholders- governments, research, startups, tech companies, smart city players and policy makers.\n\nAt its core is the real world simulation of a Smart City in a lab scale by bringing in the whole IIITH campus, its infrastructure, the students and campus residents, startups, and visitors.\n\nSmart city research centre, thus established is a combine where several research centres at IIIT collaborate and develop solutions for smart cities.The Center leverages IIIT-H ‘s research strengths in both core and domain areas.")
              ],
            )));
  }
}
