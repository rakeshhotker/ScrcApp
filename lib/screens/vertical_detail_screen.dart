import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrc/providers/vertex.dart';

import '../widgets/product_description.dart';
import '../widgets/vertex_item.dart';
import '../widgets/top_rounded_container.dart';
import '../providers/verticals.dart';
import '../size_config.dart';

class VerticalDetailScreen extends StatefulWidget {
  static const routeName = '/verticals/detail';

  @override
  _VerticalDetailScreenState createState() => _VerticalDetailScreenState();
}

class _VerticalDetailScreenState extends State<VerticalDetailScreen> {
  String _searchText = "";
  List<Vertex> _vertices = [];
  List<Vertex> _filteredVertices = [];
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle;
  var args;
  var verticalTitle;
  var vertical;
  bool _isLoading = true;
  String type;

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      setState(() {});
      args = ModalRoute.of(context).settings.arguments as List;
      vertical = Provider.of<Verticals>(context).findByTitle(args[0]);
      verticalTitle = args[1];
      _appBarTitle = Text(verticalTitle);
      vertical.vertices.forEach((element) {
        _vertices.add(element);
      });
      _filteredVertices = _vertices;
      _isLoading = false;
    }
    super.didChangeDependencies();
  }

  void _searchPressed() {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = Icon(Icons.close);
      this._appBarTitle = TextField(
        onSubmitted: (value) {
          if (value.isEmpty) {
            setState(() {
              _searchText = "";
              _filteredVertices = _vertices;
            });
          } else {
            setState(() {
              _searchText = value.toUpperCase();
            });
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: 'Search...'),
      );
    } else {
      this._searchIcon = Icon(Icons.search);
      this._appBarTitle = Text(verticalTitle);
      _filteredVertices = _vertices;
      _searchText = "";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (_searchText.isNotEmpty) {
      List<Vertex> tmp = [];
      _vertices.forEach((element) {
        if (element.nodeId.contains(_searchText)) {
          tmp.add(element);
        }
      });
      _filteredVertices = tmp;
    }
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: _appBarTitle, 
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Color(0XFF8B8B8B), fontSize: 18
              ),
              elevation: 5,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
              IconButton(
                icon: _searchIcon,
                onPressed: _searchPressed,
              ),
            ]),
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
                        child: Image.asset(
                          "assets/dashboard_icon/" + vertical.title + ".png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  TopRoundedContainer(
                      color: Colors.white,
                      child: ProductDescription(verticalTitle: verticalTitle)),
                  SizedBox(),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _filteredVertices.length,
                    itemBuilder: (ctx, i) {
                      return VertexItem(
                        index: i + 1,
                        vertex: _filteredVertices[i],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
