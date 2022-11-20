import 'package:flutter/material.dart';
import 'package:fooder/pages/order_page.dart';
import 'package:fooder/pages/home_page.dart';
import 'package:fooder/pages/splash_page.dart';
import 'package:fooder/providers/cart_provider.dart';
import 'package:fooder/providers/menu_provider.dart';
import 'package:fooder/providers/transaction_provider.dart';
import 'package:fooder/providers/voucher_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VoucherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/home-page': (context) => HomePage(),
          '/order-page': (context) => OrderPage(),
        },
      ),
      
    );
  }
}
