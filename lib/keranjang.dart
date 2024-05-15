import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: EmptyShoppingCartScreen(),
    );
  }
}

class EmptyShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Your shopping cart is empty",
              style: TextStyle(
                color: Color(0xFF67778E),
                fontFamily: 'Roboto-Light', // removed '.ttf' extension
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
