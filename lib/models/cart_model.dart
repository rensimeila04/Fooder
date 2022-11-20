

import 'package:fooder/models/menu_model.dart';
import 'package:fooder/models/voucher_model.dart';

class CartModel {
  late int id;
  late MenuModel menu;
  late VoucherModel vocer;
  

  CartModel({
    required this.id,
    required this.menu,
    required this.vocer,
    
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toInt();
    menu = MenuModel.fromJson(json['product']);
    vocer = VoucherModel.fromJson(json['vocer']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': menu.toJson(),
      'vocer': vocer.toJson(),
      
    };
  }

  
}