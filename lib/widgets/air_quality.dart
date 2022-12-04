import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class AirQuality extends StatelessWidget {
  var details;
  AirQuality({this.details});
  @override
  Widget build(BuildContext context) {
    print(details);
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8)
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(16)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DetailsTitle(imagePath: 'assets/icon/aq.png', title: 'Air Quality'),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(name: "PM10", value: details["pm10"]),
          SummaryDetailsCard(name: "PM25", value: details["pm25"]),
          SummaryDetailsCard(name: "AQI", value: details["aqi"]),
        ],
      ),
    );
  }
}
