import './vertex.dart';

import 'package:flutter/material.dart';

class Vertical with ChangeNotifier {
  final String title;
  final List<Vertex> vertices;

  Vertical({
    @required this.title,
    @required this.vertices,
  });
}
