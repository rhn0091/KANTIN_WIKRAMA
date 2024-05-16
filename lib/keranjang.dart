import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  final List cartItems;

  const ShoppingCartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          }
      ),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              // leading: Image.asset('lib/images/${widget.cartItems[index]}'),
              title: Text(widget.cartItems[index]['nama_barang']),
              subtitle: Text("Harga: ${widget.cartItems[index]['harga']}"),
              trailing: IconButton(
                icon: Icon(Icons.remove_shopping_cart),
                onPressed:() {
                  setState(() {
                    widget.cartItems.removeAt(index);
                  });
                },
              ),
        ),
          );
        },
      ),
    );
    
  }
}