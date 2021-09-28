import 'package:scrc/providers/vertex.dart';

// import '../models/http_exception.dart';

import 'vertical.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Verticals with ChangeNotifier {
  List<Vertical> _items = [];
  Map<String, dynamic> graph;

  List<Vertical> get items {
    return [..._items];
  }

  Vertical findByTitle(String title) {
    return [..._items].firstWhere((element) => element.title == title);
  }

  Future<void> fetchAndSetVerticals() async {
    var url = Uri.parse(
        "https://smartcitylivinglab.iiit.ac.in/verticals/all/latest/#");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Vertical> loadedVerticals = [];
      if (extractedData != null) {
        extractedData.forEach((prodName, prodData) {
          loadedVerticals.add(Vertical(
              title: prodName,
              vertices: (prodData as List<dynamic>)
                  .map((e) => Vertex(
                      name: e['name'],
                      nodeId: e['node_id'],
                      type: prodName,
                      latitude: e['latitude'],
                      longitude: e['longitude'],
                      data: e as Map<String, dynamic>))
                  .toList()));
        });
      }
      _items = loadedVerticals.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getGraphReadings(String type, String nodeId) async {
    final start =
        DateTime.now().subtract(Duration(days: 3, hours: 3)).toIso8601String();
    final end = DateTime.now().subtract(Duration(days: 3)).toIso8601String();
    String url = "https://smartcitylivinglab.iiit.ac.in/graph/?start=";
    url += start;
    url += "&end=";
    url += end;
    url += "&type=";
    url += type.toUpperCase().replaceAll("_", "-");
    url += "&nodes=";
    url += nodeId;
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      graph = extractedData;
      print(graph.toString());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  // Future<void> addVertical(Vertical vertical) async {
  //   var url = Uri.parse("https://shop-app-a7802.firebaseio.com/verticals.json");
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'title': vertical.title,
  //         'description': vertical.description,
  //         'imageUrl': vertical.imageUrl,
  //         'env': vertical.env,
  //         'vertices': vertical.vertices.map((e) => {
  //           'name': e.name,
  //           'latitude': e.latitude,
  //           'longitude': e.longitude
  //         }).toList()
  //       }),
  //     );
  //     var newVertical = Vertical(
  //         id: json.decode(response.body)['name'],
  //         title: vertical.title,
  //         description: vertical.description,
  //         imageUrl: vertical.imageUrl,
  //         env: vertical.env,
  //         vertices: vertical.vertices,
  //     );
  //     _items.insert(0, newVertical);
  //     print(json.decode(response.body)['name']);
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> updatevertical(String id, Vertical vertical) async {
  //   var verticalIndex = _items.indexWhere((element) => element.id == id);
  //   if (verticalIndex >= 0) {
  //     var url = Uri.parse("https://shop-app-a7802.firebaseio.com/verticals/$id.json");
  //     await http.patch(
  //       url,
  //       body: json.encode({
  //         'title': vertical.title,
  //         'description': vertical.description,
  //         'imageUrl': vertical.imageUrl,
  //         'env': vertical.env,
  //         'vertices': vertical.vertices.map((e) => {
  //           'name': e.name,
  //           'latitude': e.latitude,
  //           'longitude': e.longitude
  //         }).toList()
  //       }),
  //     );
  //     _items[verticalIndex] = vertical;
  //     notifyListeners();
  //   } else {
  //     print("...");
  //   }
  // }

  // Future<void> deleteVertical(String id) async {
  //   var url = Uri.parse("https://shop-app-a7802.firebaseio.com/verticals/$id.json");
  //   var verticalIndex = _items.indexWhere((element) => element.id == id);
  //   var existingVertical = _items[verticalIndex];
  //   _items.removeAt(verticalIndex);
  //   notifyListeners();
  //   final response = await http.delete(url);
  //   if (response.statusCode >= 400) {
  //     _items.insert(verticalIndex, existingVertical);
  //     notifyListeners();
  //     throw HttpException("Could Not Delete Vertical");
  //   }
  //   existingVertical = null;
  // }
}
