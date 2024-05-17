// import 'package:flutter/material.dart';

// class MyCart extends StatefulWidget {
//   final List<dynamic> cartItems;

//   const MyCart({Key? key, required this.cartItems}) : super(key: key);

//   @override
//   State<MyCart> createState() => _MyCartState();
// }

// class _MyCartState extends State<MyCart> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
      
//       body: 
//       ListView.builder(
//         itemCount: widget.cartItems.length,
//         itemBuilder: (context, index) {
//           dynamic item = widget.cartItems[index];
         
//           return ListTile(
//             leading: Image.asset('lib/images/open.png'),
//             title: Text(item['nama']),
//             subtitle: Text('Harga: ${item['Harga']}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {
//                     setState(() {
//                       if (item['quantity'] > 1) {
//                         item['quantity']--;
//                       }
//                     });
//                   },
//                 ),
//                 Text(item['quantity'].toString()),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       item['quantity']++;
//                     });
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     setState(() {
//                       widget.cartItems.removeAt(index);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }