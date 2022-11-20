import 'package:fooder/models/cart_model.dart';

class TransactionModel {
  int id;
  double? nominalDiskon;
  double? nominalPesanan;
  CartModel? cart;

  TransactionModel({
    required this.id,
    this.nominalDiskon,
    this.nominalPesanan,
    this.cart,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      nominalDiskon: json['nominal_diskon'],
      nominalPesanan: json['nominal_pesanan'],
      cart: CartModel.fromJson(json['cart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nominal_diskon': nominalDiskon,
      'nominal_pesanan': nominalPesanan,
      'items': cart!.toJson(),
    };
  }
}