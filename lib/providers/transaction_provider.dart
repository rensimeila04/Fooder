import 'package:flutter/material.dart';
import 'package:fooder/models/cart_model.dart';
import 'package:fooder/models/transaction_model.dart';
import 'package:fooder/services/transaction_services.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _checkouts = [];

  List<TransactionModel> get checkouts => _checkouts;

  set checkouts(List<TransactionModel> checkout) {
    _checkouts = checkout;
    notifyListeners();
  }

  cancel(){
    int id = 0;
    for(var item in checkouts){
      id += item.id;
    }
    return id;
  }

  Future<void> checkout(double nominalDiskon, double nominalPesanan,
      List<CartModel> carts) async {
    try {
      List<TransactionModel> checkout = await TransactionService()
          .checkout( nominalDiskon, nominalPesanan, carts);
      _checkouts = checkout;
    } catch (e) {
      print(e);
    }
  }

  Future cancelCheckout(int id) async {
    try {
      var result = await TransactionService().cancelCheckout(id);
      return result;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}