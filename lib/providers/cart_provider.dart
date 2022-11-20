import 'package:flutter/material.dart';
import 'package:fooder/models/cart_model.dart';
import 'package:fooder/models/menu_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  

  
}