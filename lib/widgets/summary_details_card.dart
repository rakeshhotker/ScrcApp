import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/summary.dart';

import '../providers/verticals.dart';

class SummaryDetailsCard extends StatelessWidget {
  var name;
  var value;
  SummaryDetailsCard({this.name, this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name + ": "
        ),
        Text(
          value
        )
      ],
    );
  }
}
