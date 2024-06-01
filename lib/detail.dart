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
    required this.image,
    required Null Function(Map<String, dynamic> p1) addToCart,
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  late Map<String, dynamic> listdata;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    listdata = widget.listdata;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          : FadeTransition(
              opacity: _animation,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: "product_image_${listdata['id']}",
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: widget.image,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          listdata['nama_barang'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87, // Ubah warna teks judul
                          ),
                          textAlign:
                              TextAlign.left, // Ubah posisi teks menjadi kiri
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Stok: ${listdata['jumlah']}",
                          style: TextStyle(fontSize: 16),
                          textAlign:
                              TextAlign.left, // Ubah posisi teks menjadi kiri
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Harga: ${listdata['harga']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green, // Ubah warna teks harga
                          ),
                          textAlign:
                              TextAlign.left, // Ubah posisi teks menjadi kiri
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          listdata['deskripsi'],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      ).copyWith(
        minimumSize: MaterialStateProperty.all(Size(150, 0)),
      ),
      onPressed: () {
        bool itemAlreadyInCart = cartProvider.cartItems.any(
          (item) => item['nama_barang'] == listdata['nama_barang']
        );

        if (!itemAlreadyInCart) {
          cartProvider.addToCart({
            ...listdata,
            'quantity': 1,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Produk Masuk Keranjang"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Produk Gagal Masuk"),
            ),
          );
        }
      },
      icon: Icon(Icons.add_shopping_cart),
      label: Text(
        "Masuk Keranjang".toUpperCase(),
        style: TextStyle(fontSize: 14),
      ),
    ),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      ).copyWith(
        minimumSize: MaterialStateProperty.all(Size(150, 0)),
      ),
      onPressed: () {
        // Add your Buy Now logic here
      },
      child: Text(
        "Beli".toUpperCase(),
        style: TextStyle(fontSize: 14),
      ),
    ),
  ],
),

                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
