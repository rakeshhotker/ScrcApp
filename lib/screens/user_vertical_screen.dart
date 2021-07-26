import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/verticals.dart';
import '../widgets/main_drawer.dart';
import '../widgets/user_vertical_item.dart';
import './edit_vertical_screen.dart';

class UserVerticalScreen extends StatelessWidget {
  static const routeName = "/user-verticals";

  Future<void> _refreshVerticals(BuildContext context) async {
    Provider.of<Verticals>(context).fetchAndSetVerticals();
  }

  @override
  Widget build(BuildContext context) {
    final verticals = Provider.of<Verticals>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Verticals"),
        elevation: 5,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditVerticalScreen.routeName);
              }
          )
        ],
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshVerticals(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  UserVerticalItem(
                      verticals[i].id, verticals[i].title, verticals[i].imageUrl),
                  Divider(),
                ],
              );
            },
            itemCount: verticals.length,
          ),
        ),
      ),
    );
  }
  
}
