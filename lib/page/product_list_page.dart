// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:epsi_shop/cart.dart';
import 'package:flutter/material.dart';
import 'package:epsi_shop/product.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});
  final product = Product(
    id: 1,
    title: 'Cluse Backpack',
    price: 49.99,
    description: 'To pick up things',
    category: 'Backpack',
    image: 'https://cluse.com/cdn/shop/files/CX04403_frontal.jpg?v=1723798776&width=900'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EPSI Shop'),
        actions: [
          IconButton(
            icon: Badge (
              label: Text(context.watch<Cart>().getAll().length.toString()),
              child: const Icon(Icons.shopping_cart),
              ),
            onPressed: () => context.go('/cart'),
          ),
        ],
      ),
      // Use FutureBuilder to fetch data from the API
      body: FutureBuilder<List<Product>>(
        future: fetchListProduct(),
        builder: (context, snapshot) {
          // Check if the snapshot has data
          if(snapshot.hasData && snapshot.data != null){
            return ListProducts(listProducts: snapshot.data!);

          // Check if the snapshot has error
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');

          // If the snapshot is still loading
          } else {
            return const CircularProgressIndicator();
          }  
        }
      ),
    );
  }

  Future<List<Product>> fetchListProduct() async {
    // Get data from Fakestore API
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    // Check if the response is OK
    if (response.statusCode == 200) {
      // Convert the response body to a list of map
      final listProductsMap = json.decode(response.body) as List<dynamic>;

      // Convert the list of map to a list of Product
      return listProductsMap
      .map((map) => Product(
        id: map['id'],
        title: map['title'],
        price: map['price'].toDouble(),
        description: map['description'],
        category: map['category'],
        image: map['image']
      ))
      .toList();

    // If the response is not OK
    } else {
      throw Exception('Failed to load product');
    }
  }
}

class ListProducts extends StatelessWidget {
  // Create a list of Product
  final List<Product> listProducts;
  const ListProducts({
    super.key,
    required this.listProducts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Create a list of ListTile
      itemCount: listProducts.length,
      itemBuilder: (context, index) => ListTile(
        // Navigate to the detail page when the ListTile is tapped
        onTap: () => context.go('/detail', extra: listProducts[index]),
        leading: Image.network(
          listProducts[index].image,
          height: 80,
          width: 80,
        ),
        title: Text(listProducts[index].title),
      ),
    );
  }
}