import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';
import 'package:scrc/size_config.dart';
import 'package:scrc/widgets/details_title.dart';
import 'package:scrc/widgets/summary_details_card.dart';

import '../providers/verticals.dart';

class Deployment extends StatelessWidget {
  var details;
  Deployment({this.details});
  @override
  Widget build(BuildContext context) {
    var summ = details["sr_ac"]["nodes"] +
        details["sr_aq"]["nodes"] +
        details["sr_em"]["nodes"] +
        details["sr_oc"]["nodes"];
    print(details);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(16)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsTitle(imagePath: 'assets/icon/s.png', title: 'Deployment'),

          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SummaryDetailsCard(
              name: "Weather Station", value: details["we"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "Air Quality", value: details["aq"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "Water Distribution", value: details["wd"]["nodes"].toString()),
          SummaryDetailsCard(name: "Water Flow", value: details["wf"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "Weather Station", value: details["we"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "Solar Energy", value: details["sl"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "Energy Monitoring", value: details["em"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "Smart Room (total)", value: summ.toString()),
          SummaryDetailsCard(
              name: "  - Air Conditioning", value: details["sr_ac"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "  - Occupancy", value: details["sr_oc"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "  - Air Quality", value: details["sr_aq"]["nodes"].toString()),
          SummaryDetailsCard(
              name: "  - Energy Monitoring", value: details["sr_em"]["nodes"].toString()),
          SummaryDetailsCard(
            name: "  - Wisun Deployment", value: details["wn"]["nodes"].toString()
          )
        ],
      ),
    );
  }
}
