import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kantin_wk/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
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
                    // Example image, replace with item image
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(8),
                    //   child: Image.asset(
                    //     item['image'] ?? 'lib/images/default.jpg',
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
                            "Harga: ${item['harga']}",
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
                          icon: Icon(Icons.delete, color: Colors.red),
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
    );
  }
}
