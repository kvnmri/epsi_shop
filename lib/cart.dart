import 'package:flutter/material.dart';
import 'product.dart';

class Cart extends ChangeNotifier{
  final _listProducts = <Product>[];

  void add(Product product){
    _listProducts.add(product);
    notifyListeners();
  }

  void remove(Product product){
    _listProducts.remove(product);
    notifyListeners();
  }

  List<Product> getAll() => _listProducts;

  double getTotalPrice() {
    return _listProducts.fold(0, (total, current) => total + current.price);
  }

  double getTotalPriceWithTax() {
    return getTotalPrice() * 1.2;
  }
}
