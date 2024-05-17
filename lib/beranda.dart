import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kantin_wk/detail.dart';
import 'package:kantin_wk/keranjang.dart';
import 'package:kantin_wk/main.dart';
import 'dart:convert';
import 'package:kantin_wk/provider.dart';
import 'package:provider/provider.dart';

class Beranda extends StatefulWidget {
  final Map<String, dynamic> listdata;

  const Beranda({Key? key, required this.listdata}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final TextEditingController _searchController = TextEditingController();
  List _listdata = [];

  final List<String> items = [
    'lib/images/anggur.jpg',
    'lib/images/piscok.jpg',
    'lib/images/jus.jpg',
  ];

  Future<void> _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/kantin/koneksi.php'));

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kantin Wisaga",
              style: TextStyle(fontWeight: FontWeight.bold)),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(241, 30, 181, 204),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  // implement search logic here
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _listdata.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            listdata: _listdata[index],
                            image: Image.asset(items[index % items.length]), addToCart: (Map<String, dynamic> p1) {  },
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              items[index % items.length],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listdata[index]['nama_barang'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Harga: ${_listdata[index]['harga']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 73, 137, 148),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
