// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/verticals.dart';
// import '../screens/edit_vertical_screen.dart';

// class UserVerticalItem extends StatelessWidget {
//   final String id;
//   final String title;
//   final String imageUrl;

//   UserVerticalItem(this.id, this.title, this.imageUrl);
//   @override
//   Widget build(BuildContext context) {
//     final scaffold = ScaffoldMessenger.of(context);
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(imageUrl),
//       ),
//       title: Text(title),
//       trailing: Container(
//         width: 100,
//         child: Row(children: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               Navigator.of(context)
//                   .pushNamed(EditVerticalScreen.routeName, arguments: id);
//             },
//             color: Theme.of(context).primaryColor,
//           ),
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               return showDialog(
//                 context: context,
//                 builder: (ctx) {
//                   return AlertDialog(
//                     title: Text("Are You Sure??"),
//                     content: Text("Do you want to remove this Vertical?"),
//                     elevation: 4,
//                     actions: [
//                       TextButton(
//                           onPressed: () {
//                             Navigator.of(ctx).pop(false);
//                           },
//                           child: Text("No")),
//                       TextButton(
//                         onPressed: () async {
//                           try {
//                             await Provider.of<Verticals>(context, listen: false).deleteVertical(id);
//                           } catch (error) {
//                             scaffold.showSnackBar(SnackBar(content: Text("Deleting Failed")));
//                           }
//                           Navigator.of(ctx).pop(true);
//                         }, 
//                         child: Text("Yes")
//                       ),
//                     ],
//                   );
//                 }
//               );
//             },
//             color: Theme.of(context).errorColor,
//           ),
//         ]),
//       ),
//     );
//   }
// }
