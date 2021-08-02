import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './verticals_overview_screen.dart';
import '../widgets/main_drawer.dart';
import '../widgets/product_description.dart';
import '../widgets/vertex_item.dart';
import '../widgets/top_rounded_container.dart';
import '../providers/verticals.dart';
import '../size_config.dart';

class VerticalDetailScreen extends StatelessWidget {
  static const routeName = '/verticals/detail';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final verticalTitle = ModalRoute.of(context).settings.arguments as String;
    final vertical = Provider.of<Verticals>(context).findByTitle(verticalTitle);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
            .pushReplacementNamed(VerticalsOverviewScreen.routeName);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(vertical.title),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(238),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: vertical.title.toString(),
                    child: Image.asset("assets/icon/" + vertical.title + ".png", fit: BoxFit.cover,),
                  ),
                ),
              ),
              TopRoundedContainer(
                  color: Colors.white,
                  child: ProductDescription(vertical: vertical)),
              SizedBox(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: vertical.vertices.length,
                itemBuilder: (ctx, i) {
                  return VertexItem(
                    index: i + 1,
                    vertex: vertical.vertices[i],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
