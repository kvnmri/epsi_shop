// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:epsi_shop/cart.dart';
import 'package:epsi_shop/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFEBEBEB),
              child: Image.network(
                product.image,
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Flexible(
                    child: Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    product.prixEuro(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category: ${product.category}',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text (product.description),
                ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Cart>(context, listen: false).add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.title} added to cart')),);
              }, 
              child: const Text('Add to cart'),
            ),
            FutureBuilder(
              future: wait5Seconds(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text('Data loaded');

                } else {
                  return CircularProgressIndicator();
                }
              }
            )
          ],
        ),
      )
    );
  }
  Future<bool> wait5Seconds() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}