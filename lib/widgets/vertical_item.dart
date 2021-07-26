import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/vertical.dart';
import '../screens/vertical_detail_screen.dart';

class VerticalItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final vertical = Provider.of<Vertical>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(VerticalDetailScreen.routeName,
            arguments: vertical.id);
        },
        child: GridTile(
          child: Image.network(
            vertical.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Container(
              margin: EdgeInsets.only(left: 5),
                child: Text(
                vertical.title, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            title: SizedBox(),
            trailing: Container(
              margin: EdgeInsets.only(right: 5),
              child: Text(
                vertical.vertices.length.toString(), 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
