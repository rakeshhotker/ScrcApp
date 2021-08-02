// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../size_config.dart';
// import '../providers/vertex.dart';
// import '../widgets/vertex_form.dart';
// import '../providers/vertical.dart';
// import '../providers/verticals.dart';

// class EditVerticalScreen extends StatefulWidget {
//   static const routeName = "/user-verticals/edit";

//   @override
//   _EditVerticalScreenState createState() => _EditVerticalScreenState();
// }

// class _EditVerticalScreenState extends State<EditVerticalScreen> {
//   List<VertexForm> vertices = [];
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _form = GlobalKey<FormState>();
//   var _editedVertical = Vertical(
//       id: null,
//       title: "",
//       description: "",
//       imageUrl: "",
//       env: "",
//       vertices: []);
//   var _isInit = true;
//   var _initValues = {
//     'title': "",
//     'description': "",
//   };
//   var _isLoading = false;

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final verticalId = ModalRoute.of(context).settings.arguments as String;
//       if (verticalId != null) {
//         _editedVertical = Provider.of<Verticals>(context).findById(verticalId);
//         _initValues = {
//           'title': _editedVertical.title,
//           'description': _editedVertical.description,
//           'env': _editedVertical.env
//         };
//         _editedVertical.vertices.forEach((_vertex) {
//           vertices.add(VertexForm(
//             vertex: _vertex,
//             onDelete: () => onDelete(_vertex),
//           ));
//         });
//         _imageUrlController.text = _editedVertical.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Vertical"),
//         elevation: 5,
//         actions: [
//           IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
//         ],
//       ),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: EdgeInsets.all(getProportionateScreenHeight(15)),
//               child: Form(
//                   key: _form,
//                   child: ListView(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 12, right: 12, top: 12),
//                         child: TextFormField(
//                           initialValue: _initValues['title'],
//                           textInputAction: TextInputAction.next,
//                           onFieldSubmitted: (_) {
//                             FocusScope.of(context)
//                                 .requestFocus(_descriptionFocusNode);
//                           },
//                           onSaved: (value) {
//                             _editedVertical = Vertical(
//                               id: _editedVertical.id,
//                               title: value,
//                               description: _editedVertical.description,
//                               imageUrl: _editedVertical.imageUrl,
//                               env: _editedVertical.env,
//                               vertices: [],
//                             );
//                           },
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return "Please Enter some value.";
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Vertical Name',
//                             labelStyle: TextStyle(height: 0.5),
//                             icon: Icon(Icons.corporate_fare),
//                             isDense: true,
//                           ),
//                         ),
//                       ),
//                       SizedBox(),
//                       Padding(
//                         padding: EdgeInsets.only(left: 12, right: 12, top: 12),
//                         child: TextFormField(
//                           keyboardType: TextInputType.multiline,
//                           maxLines: 3,
//                           initialValue: _initValues['description'],
//                           focusNode: _descriptionFocusNode,
//                           onSaved: (value) {
//                             _editedVertical = Vertical(
//                               id: _editedVertical.id,
//                               title: _editedVertical.title,
//                               description: value,
//                               imageUrl: _editedVertical.imageUrl,
//                               env: _editedVertical.env,
//                               vertices: [],
//                             );
//                           },
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return "Please Enter some Description";
//                             }
//                             if (value.length < 10) {
//                               return "Description should have atleast 10 characters";
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Vertical Description',
//                             labelStyle: TextStyle(height: 0.5),
//                             icon: Icon(Icons.description),
//                             isDense: true,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 12, right: 12, top: 12),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               width: getProportionateScreenHeight(100),
//                               height: getProportionateScreenHeight(100),
//                               margin: EdgeInsets.only(
//                                 top: getProportionateScreenHeight(8),
//                                 right: getProportionateScreenHeight(10),
//                               ),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   image: DecorationImage(
//                                       image: NetworkImage(
//                                           _imageUrlController.text),
//                                       fit: BoxFit.cover)),
//                             ),
//                             Divider(),
//                             Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(
//                                   bottom: getProportionateScreenHeight(8),
//                                   right: getProportionateScreenHeight(10),
//                                 ),
//                                 alignment: Alignment.center,
//                                 // padding:
//                                     // EdgeInsets.only(left: 12, right: 12, top: 12),
//                                 child: TextFormField(
//                                   initialValue: _initValues['env'],
//                                   textInputAction: TextInputAction.next,
//                                   onSaved: (value) {
//                                     _editedVertical = Vertical(
//                                       id: _editedVertical.id,
//                                       title: _editedVertical.title,
//                                       description: _editedVertical.description,
//                                       imageUrl: _editedVertical.imageUrl,
//                                       env: value,
//                                       vertices: [],
//                                     );
//                                   },
//                                   validator: (value) {
//                                     if (value.isEmpty) {
//                                       return "Please Enter some value.";
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     labelText: 'Enviornment variable',
//                                     labelStyle: TextStyle(height: getProportionateScreenHeight(0.5)),
//                                     icon: Icon(Icons.corporate_fare),
//                                     isDense: true,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(),
//                       Padding(
//                         padding: EdgeInsets.only(left: 12, right: 12, top: 12),
//                         child: TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Image URL',
//                               labelStyle: TextStyle(height: 0.5),
//                               icon: Icon(Icons.image),
//                               isDense: true,
//                             ),
//                             keyboardType: TextInputType.url,
//                             textInputAction: TextInputAction.done,
//                             controller: _imageUrlController,
//                             focusNode: _imageUrlFocusNode,
//                             onFieldSubmitted: (_) {
//                               _saveForm();
//                             },
//                             onSaved: (value) {
//                               _editedVertical = Vertical(
//                                 id: _editedVertical.id,
//                                 title: _editedVertical.title,
//                                 description: _editedVertical.description,
//                                 imageUrl: value,
//                                 env: _editedVertical.env,
//                                 vertices: [],
//                               );
//                             },
//                             validator: (value) {
//                               if (value.isEmpty) {
//                                 return "Please Enter URL.";
//                               }
//                               return null;
//                             })                      
//                           ),
//                         if (vertices.length > 0)
//                         Container(
//                           child: ListView.builder(
//                             addAutomaticKeepAlives: true,
//                             itemCount: vertices.length,
//                             physics: ScrollPhysics(),
//                             shrinkWrap: true,
//                             itemBuilder: (_, i) => vertices[i],
//                           ),
//                         ),
//                     ],
//                   )),
//             ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: onAddForm,
//         foregroundColor: Colors.white,
//       ),
//     );
//   }

//   ///on form user deleted
//   void onDelete(Vertex _vertex) {
//     setState(() {
//       var find = vertices.firstWhere(
//         (it) => it.vertex == _vertex,
//         orElse: () => null,
//       );
//       if (find != null) vertices.removeAt(vertices.indexOf(find));
//     });
//   }

//   ///on add form
//   void onAddForm() {
//     setState(() {
//       var _vertex = Vertex();
//       vertices.add(VertexForm(
//         vertex: _vertex,
//         onDelete: () => onDelete(_vertex),
//       ));
//     });
//   }

//   Future<void> _saveForm() async {
//     if (!_form.currentState.validate()) {
//       return;
//     }
//     if (vertices.length <= 0) {
//       Fluttertoast.showToast(
//           msg: "Please Add Nodes",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//       return;
//     } else {
//       var allValid = true;
//       vertices.forEach((form) => allValid = (allValid && form.isValid()));
//       if (!allValid) {
//         return;
//       }
//     }
//     setState(() {
//       _isLoading = true;
//     });
//     var data = vertices.map((it) => it.vertex).toList();
//     _form.currentState.save();
//     _editedVertical = Vertical(
//       title: _editedVertical.title,
//       description: _editedVertical.description,
//       env: _editedVertical.env,
//       id: _editedVertical.id,
//       imageUrl: _editedVertical.imageUrl,
//       vertices: data
//     );
//     if (_editedVertical.id != null) {
//       await Provider.of<Verticals>(context, listen: false)
//           .updatevertical(_editedVertical.id, _editedVertical);
//       Navigator.of(context).pop();
//       setState(() {
//         _isLoading = false;
//       });
//     } else {
//       try {
//         await Provider.of<Verticals>(context, listen: false)
//             .addVertical(_editedVertical);
//       } catch (error) {
//         await showDialog(
//             context: context,
//             builder: (ctx) {
//               return AlertDialog(
//                 title: Text("Something went Wrong!!"),
//                 content: Text("Plz try Again"),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(ctx).pop();
//                       },
//                       child: Text("Dismiss"))
//                 ],
//               );
//             });
//       } finally {
//         Navigator.of(context).pop();
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
// }
