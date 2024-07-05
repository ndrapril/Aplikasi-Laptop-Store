import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_kelompok/provider/cart_provider.dart';
import 'package:project_kelompok/screen/home_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return ListTile(
            leading: Image.asset(product.image),
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                cartProvider.removeFromCart(product);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              cartProvider.checkout(); // Panggil fungsi checkout saat tombol ditekan
              // Tambahkan logika lain sesuai kebutuhan, misalnya navigasi ke halaman konfirmasi pesanan
            },
            child: const Text('Checkout'),
          ),
        ),
      ),
    );
  }
}
