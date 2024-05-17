import 'package:flutter/material.dart';
import 'package:kantin_wk/keranjang.dart';
import 'package:kantin_wk/provider.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> listdata;
  final Image image;

  const Detail({
    Key? key,
    required this.listdata,
    required this.image, required Null Function(Map<String, dynamic> p1) addToCart,
  }) : super(key: key);

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
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kantin Wisaga"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(118, 103, 188, 182),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
      body: listdata.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 120, 194, 204),
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          bool itemAlreadyInCart = cartProvider.cartItems.any(
                              (item) => item['nama_barang'] == listdata['nama_barang']);

                          if (!itemAlreadyInCart) {
                            cartProvider.addToCart({
                              ...listdata,
                              'quantity': 1,
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item added to cart"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item already in cart"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Add to cart".toUpperCase(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          "Buy now".toUpperCase(),
                          style: TextStyle(fontSize: 14),
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 120, 194, 204)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 120, 194, 204)),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Add your Buy Now logic here
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
