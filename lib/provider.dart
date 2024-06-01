// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  var totalPrice;

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
 String calculatetotal() {
  double totalPrice = 0;
  for (var item in _cartItems) {
    totalPrice += double.parse(item['harga'].toString()) * item['quantity'];
  }
  return totalPrice.toStringAsFixed(2);
}
 void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void purchaseItems() {
    // Add your purchase logic here, such as sending data to a server
    clearCart();
  }
}
