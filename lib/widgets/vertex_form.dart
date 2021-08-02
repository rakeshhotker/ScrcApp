// import 'package:flutter/material.dart';

// import '../providers/vertex.dart';

// typedef OnDelete();

// class VertexForm extends StatefulWidget {
//   final Vertex vertex;
//   final state = _VertexFormState();
//   final OnDelete onDelete;

//   VertexForm({Key key, this.vertex, this.onDelete}) : super(key: key);
//   @override
//   _VertexFormState createState() => state;

//       bool isValid() => state.validate();
//   }

// class _VertexFormState extends State<VertexForm> {
//   final form = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {    
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Material(
//         elevation: 1,
//         clipBehavior: Clip.antiAlias,
//         borderRadius: BorderRadius.circular(8),
//         child: Form(
//           key: form,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               AppBar(
//                 elevation: 5,
//                 title: Text('Vertex Details'),
//                 backgroundColor: Colors.teal[50],
//                 centerTitle: true,
//                 leading: Icon(Icons.vertical_split_outlined),
//                 actions: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.delete),   
//                     onPressed: widget.onDelete,
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 16),
//                 child: TextFormField(
//                   initialValue: widget.vertex.name,
//                   onSaved: (val) => widget.vertex.name = val,
//                   validator: (val) =>
//                       val.length > 3 ? null : 'Full name is invalid',
//                   decoration: InputDecoration(
//                     labelText: 'Node Name',
//                     labelStyle: TextStyle(height: 0.5),
//                     icon: Icon(Icons.control_point),
//                     isDense: true,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 16),
//                 child: TextFormField(
//                   initialValue: widget.vertex.latitude,
//                   onSaved: (val) => widget.vertex.latitude = val,
//                   validator: (val) =>
//                       val.length > 4 ? null : 'Latitude is invalid',
//                   decoration: InputDecoration(
//                     labelText: 'Latitude',
//                     labelStyle: TextStyle(height: 0.5),
//                     icon: Icon(Icons.location_pin),
//                     isDense: true,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 16),
//                 child: TextFormField(
//                   initialValue: widget.vertex.longitude,
//                   onSaved: (val) => widget.vertex.longitude = val,
//                   validator: (val) =>
//                       val.length > 4 ? null : 'Longitude is invalid',
//                   decoration: InputDecoration(
//                     labelText: 'Longitude',
//                     labelStyle: TextStyle(height: 0.5),
//                     icon: Icon(Icons.location_pin),
//                     isDense: true,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   ///form validator
//   bool validate() {
//     var valid = form.currentState.validate();
//     if (valid) form.currentState.save();
//     return valid;
//   }
// }
