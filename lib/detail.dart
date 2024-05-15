// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:kantin_wk/beranda.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> listdata;
  final Image image;

  const Detail({Key? key, required this.listdata, required this.image}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Map<String, dynamic> listdata;

  @override
  void initState() {
    super.initState();
    listdata = widget.listdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kantin Wisaga"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(118, 103, 188, 182),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Beranda(listdata: {})),
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
      body: listdata.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Center(
                  child: Container(
                    height: 250,
                    child: widget.image,
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    listdata['nama_barang'],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Stok: ${listdata['jumlah']}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    listdata['deskripsi'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text(
                        "Add to cart".toUpperCase(),
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () => null,
                    ),
                    ElevatedButton(
                      child: Text(
                        "Buy now".toUpperCase(),
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () => null,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
