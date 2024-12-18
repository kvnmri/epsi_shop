// ignore_for_file: prefer_const_constructors

import 'package:epsi_shop/cart.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/product_detail_page.dart';
import 'package:epsi_shop/page/product_list_page.dart';
import 'package:epsi_shop/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final router = GoRouter(routes: [
    GoRoute(path: '/',
      builder:(context, state) => ProductListPage(),
      routes: [
        GoRoute(
          path: 'detail',
          builder:(context, state) => ProductDetailPage(product:state.extra as Product)
        ),
        GoRoute(
          path: 'cart',
          builder:(context, state) => CartPage()
        )
      ]
    )
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          appBarTheme: AppBarTheme(
            backgroundColor: ColorScheme.fromSeed(seedColor: Colors.blue).primary,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
