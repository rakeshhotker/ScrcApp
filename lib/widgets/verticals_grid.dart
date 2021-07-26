import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'vertical_item.dart';
import '../providers/verticals.dart';

class VerticalsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final verticalsData = Provider.of<Verticals>(context);
    final verticals = verticalsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: verticals[i],
          child: VerticalItem(),
        );
      },
      itemCount: verticals.length,
    );
  }
}
