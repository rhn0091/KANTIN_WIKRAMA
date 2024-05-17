// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cart/cart.dart'; 

// class MyHome extends StatefulWidget {
//   const MyHome({Key? key}) : super(key: key);

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   StreamController<dynamic> streamController = StreamController<dynamic>();
//   Timer? _timer;
//   final List<String> items = [
//     '/Users/mrasheed/cart/lib/images/tahu.png',
//     '/Users/mrasheed/cart/lib/images/tempe.png',
//     '/Users/mrasheed/cart/lib/images/telur.png',
//     '/Users/mrasheed/cart/lib/images/risol.png'
//   ];
//   List<dynamic> cartItems = []; 

//   Future<void> _ambilData() async {
//     var response = await http.get(Uri.parse('http://localhost/flutter/read.php'));
//     var data = jsonDecode(response.body);

//     streamController.add(data);
//   }

//   @override
//   void initState() {
//     _ambilData();

//     _timer = Timer.periodic(Duration(seconds: 5), (timer) => _ambilData());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     streamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyCart(cartItems: cartItems))),
//         backgroundColor: Colors.green,
//         child: Icon(Icons.shopping_cart),
//       ),
//       backgroundColor: Colors.white,
//       body: Container(
//       color: Colors.white,
//       child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//              Padding(
//               padding: EdgeInsets.only(
//                 top: 0,
//                 bottom: 0,
//                 left: 100,
//                 right: 100,
//               ),
//               child: Image(
//                   image:
//                       AssetImage('/Users/mrasheed/cart/lib/images/open.png'))),
//             StreamBuilder<dynamic>(
//             stream: streamController.stream,
//             builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List dataList = snapshot.data;
//               return ListView.builder(
//               shrinkWrap: true,
//               itemCount: dataList.length,
//               itemBuilder: (context, index) {
//               return Card(
//                 elevation: 4,
//                 child: ListTile(
//                 leading: Image.asset(items[index], width: 200, height: 200),
//                 title: Text('${dataList[index]['nama']}'),
//                 subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                 SizedBox(height: 8),
//                 Text('Harga: ${dataList[index]['Harga']}'),
//                 SizedBox(height: 4),
//                 Text('Stock: ${dataList[index]['Stock']}'),
//                 SizedBox(height: 4),
//                   Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                   TextButton(
//                     child: Text("Add to cart".toUpperCase(), style: TextStyle(fontSize: 14)),
//                     style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
//                     foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 44, 167, 77)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                     side: BorderSide(color: Color.fromARGB(255, 44, 167, 77)),
//                               ),
//                             ),
//                           ),
//                       onPressed: () {
//                   setState(() {
//                     bool itemAlreadyInCart = cartItems.any((item) =>dataList[index]['idBarang'] == dataList[index]['idBarang']);
                    
//                   if (!itemAlreadyInCart) {
     
//       cartItems.add({
//         ...dataList[index],
//         'quantity': 1, 
//       });
//     }
//                               });
//                             },
//                           ),
//                       SizedBox(width: 5),
//                         ElevatedButton(
//                         child: Text("Information".toUpperCase(), style: TextStyle(fontSize: 14)),
//                         style: ButtonStyle(
//                         foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
//                         backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 33, 175, 45)),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                         side: BorderSide(color: Colors.yellow),
//                                       ),
//                                     ),
//                                   ),
//                         onPressed: () {
//                         showModalBottomSheet<void>(
//                         context: context,
//                         builder: (BuildContext context) {
//                         return Container(
//                         height: 200,
//                         color: const Color.fromARGB(255, 251, 251, 251),
//                         child: Center(
//                         child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                         Text('${dataList[index]['info']}'),
//                           ElevatedButton(
//                             child: const Text('Close'),
//                             onPressed: () => Navigator.pop(context),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },);
//           } else {
//           return Center(
//           child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }