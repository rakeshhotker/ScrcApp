import 'package:scrc/providers/vertex.dart';
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

}
