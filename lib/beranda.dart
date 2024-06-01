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
    'lib/images/cilok.jpg',
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
          title: Text(
            "Kantin Wisaga",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF67BCB6), Color(0xFF1E8EC8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
           leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Logout"),
                  content: Text("Apakah Anda yakin ingin logout?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Batal"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Ya"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                    ),
                  ],
                );
              },
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
                    builder: (context) => ShoppingCartScreen(
                      
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF1B5CC), Color(0xFF30B5CC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // Add search functionality if needed
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(70),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
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
                              image: Image.asset(items[index % items.length]),
                              addToCart: (Map<String, dynamic> p1) {},
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.asset(
                                  items[index % items.length],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
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
                                      fontSize: 14, // Decreased font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Harga: ${_listdata[index]['harga']}",
                                    style: TextStyle(
                                      fontSize: 12, // Decreased font size
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
      ),
    );
  }
}
