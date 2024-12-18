import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart.dart';
//import '../product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          final products = cart.getAll();
          final totalPriceWithTax = cart.getTotalPriceWithTax();
          if (products.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: ${totalPriceWithTax.toStringAsFixed(2)} € (incl. 20% VAT)',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.image),
                      title: Text(product.title),
                      subtitle: Text('${product.price} €'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          cart.remove(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Checkout logic
                  },
                  child: const Text('Proceed to payment'),)
              ,)
            ],
          );
        },
      ),
    );
  }
}