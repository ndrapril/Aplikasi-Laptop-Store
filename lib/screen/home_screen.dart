import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_kelompok/provider/cart_provider.dart' as CartProvider;
import 'package:project_kelompok/screen/cart_screen.dart';
import 'package:project_kelompok/screen/profile_screen.dart';
import 'package:provider/provider.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider.CartProvider>(context);
    final products = [
      CartProvider.Product(
        name: 'Acer Nitro',
        image: 'images/acer_nitro.png',
        price: '1000',
        description: 'Description of Laptop 1',
      ),
      CartProvider.Product(
        name: 'Asus ROG',
        image: 'images/asus_rog.png',
        price: '1200',
        description: 'Description of Laptop 2',
      ),
      CartProvider.Product(
        name: 'Asus TUF',
        image: 'images/asus_tuf.png',
        price: '1500',
        description: 'Description of Laptop 3',
      ),
      CartProvider.Product(
        name: 'HP Pavilion',
        image: 'images/hp_pavilion.png',
        price: '1800',
        description: 'Description of Laptop 4',
      ),
      CartProvider.Product(
        name: 'Lenovo Legion',
        image: 'images/lenovo_legion.png',
        price: '2000',
        description: 'Description of Laptop 5',
      ),
      // Daftar produk lainnya
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laptop Store"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(product.image, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("\$${product.price}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                cartProvider.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Added to cart"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: const Text("Add to Cart"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Spacer
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
