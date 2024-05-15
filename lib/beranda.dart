import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kantin_wk/detail.dart';
import 'dart:convert';

import 'package:kantin_wk/main.dart';

class Beranda extends StatefulWidget {
  final Map<String, dynamic> listdata;

  const Beranda({Key? key, required this.listdata}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
TextEditingController serch = TextEditingController();

  List listdata = [];
  final List<String> items = [
    'lib/images/anggur.jpg',
    'lib/images/piscok.jpg',
  ];

  Future<void> getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/kantin/koneksi.php'));

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kantin Wisaga"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(118, 103, 188, 182),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart_checkout),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(241, 30, 181, 204),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: serch,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  // Implement your search logic here
                  setState(() {
                    // You can filter your listdata based on the search value here
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listdata.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.asset(items[index]),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              listdata[index]['nama_barang'],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Text(
                            "Harga: ${listdata[index]['harga']}",
                            style: TextStyle(fontSize: 16.0, color: Colors.red),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              listdata: listdata[index],
                              image: Image.asset(items[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class beranda extends StatefulWidget {
//   const beranda({super.key});

//   @override
//   State<beranda> createState() => beranda1();
// }

// class beranda1 extends State<beranda> {
//   List listdata = [];

//   Future<void> getdata() async {
//     try{
//       final response =
//      await http.get(Uri.parse('http://localhost/kantin/koneksi.php'));

//       if (response.statusCode == 200) {
//         print(response.body);
//         final data = jsonDecode(response.body);
//         setState(() {
//           listdata = data;
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Kantin Wisaga"),
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(118, 103, 188, 182),
//           leading: IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {

//             },
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.shopping_cart_checkout),
//               onPressed: () {

//               },
//             ),
//           ],
//         ),
//       ),
//     );
// }
// }
// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: listdata,
//     );
//   }
// }