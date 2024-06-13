import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kantin_wk/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang Belanja"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF67BCB6), Color(0xFF1E8EC8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartProvider.cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          // Contoh gambar, ganti dengan gambar item
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(8),
                          //   child: Image.asset(
                          //     item['image']?? 'lib/images/default.jpg',
                          //     height: 80,
                          //     width: 80,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['nama_barang'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 42, 75, 78),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Jumlah: ${item['quantity']}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 42, 75, 78),
                                  ),
                                ),
                                Text(
                                  "Harga: Rp${item['harga']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 42, 75, 78),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  cartProvider.decreaseQuantity(item);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () {
                                  cartProvider.increaseQuantity(item);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_shopping_cart,
                                    color: Colors.red),
                                onPressed: () {
                                  cartProvider.removeFromCart(item);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF67BCB6),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Harga",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Rp ${cartProvider.calculatetotal()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Memunculkan dialog konfirmasi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Konfirmasi Pembelian"),
                        content: Text(
                            "Apakah Anda yakin ingin membeli barang-barang ini?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Batal"),
                          ),
                          ElevatedButton(
  onPressed: () async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/ukk_amri/read.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'items': cartProvider.cartItems,
          'total_harga': cartProvider.calculatetotal(),
        }),
      );

      if (response.statusCode == 200) {
        for (var item in cartProvider.cartItems) {
          await http.post(
            Uri.parse('http://localhost/ukk_amri/read.php'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'nama_barang': item['nama_barang'],
              'jumlah': item['quantity'],
            }),
          );
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Pembelian berhasil"),
          ),
        );
        cartProvider.clearCart();
      } else {
        // Gagal melakukan pembelian
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Pembelian gagal"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
        ),
      );
    }
  },
  child: Text("Beli"),
),
                        ],
                      );
                    },
                  );
                },
                child: Text("Beli"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
