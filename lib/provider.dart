import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item) {
    bool itemExists = false;
    for (var cartItem in _cartItems) {
      if (cartItem['nama_barang'] == item['nama_barang']) {
        cartItem['quantity'] += 1;
        itemExists = true;
        break;
      }
    }
    if (!itemExists) {
      item['quantity'] = 1;
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void increaseQuantity(Map<String, dynamic> item) {
    for (var cartItem in _cartItems) {
      if (cartItem['nama_barang'] == item['nama_barang']) {
        cartItem['quantity'] += 1;
        break;
      }
    }
    notifyListeners();
  }

  void decreaseQuantity(Map<String, dynamic> item) {
    for (var cartItem in _cartItems) {
      if (cartItem['nama_barang'] == item['nama_barang']) {
        if (cartItem['quantity'] > 1) {
          cartItem['quantity'] -= 1;
        } else {
          _cartItems.remove(cartItem);
        }
        break;
      }
    }
    notifyListeners();
  }
}
