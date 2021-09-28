import 'package:flutter/material.dart';
// import 'package:scrc/providers/vertical.dart';

import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.verticalTitle,
  }) : super(key: key);

  final String verticalTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            verticalTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(8)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          // child: Text(
          //   vertical.description,
          //   maxLines: 3,
          // ),
        ),
      ],
    );
  }
}
