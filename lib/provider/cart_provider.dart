import 'package:flutter/material.dart';
import 'package:project_kelompok/screen/home_screen.dart';

class Product {
  final String name;
  final String image;
  final String price;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void checkout() {
    // Lakukan proses checkout sesuai kebutuhan Anda
    // Misalnya, mengirim pesanan, menghitung total harga, dll.
    
    // Setelah proses checkout selesai, kosongkan keranjang
    _cartItems.clear();
    notifyListeners();
  }
}
