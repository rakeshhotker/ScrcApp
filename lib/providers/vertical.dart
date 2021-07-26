import './vertex.dart';

import 'package:flutter/material.dart';

class Vertical with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String env;
  final List<Vertex> vertices;

  Vertical({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.env,
    @required this.vertices
  });
}
