import 'dart:convert';
import 'package:fooder/models/cart_model.dart';
import 'package:fooder/models/transaction_model.dart';
import 'package:http/http.dart' as http;


class TransactionService {
  String baseUrl = 'https://tes-mobile.landa.id/api';

  Future<List<TransactionModel>> checkout( double nominalDiskon,
      double nominalPesanan, List<CartModel> carts) async {
    var url = '$baseUrl/order';
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode({
      'nominal_diskon': nominalDiskon,
      'nominal_pesanan': nominalPesanan,
      'items': carts
          .map((cart) => {
                'id': cart.menu.id,
                'harga': cart.menu.harga,
                'catatan': cart.menu.catatan,
              })
          .toList()
    });

    print(body);
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      int idTransaction = json.decode(response.body)['id'];
      List<TransactionModel> transactions = [];

      for (var i = 0; i < carts.length; i++) {
        transactions.add(TransactionModel(
          id: idTransaction,
          nominalDiskon: nominalDiskon,
          nominalPesanan: nominalPesanan,
          cart: carts[i],
        ));
      }

      return transactions;
    } else {
      throw Exception('Gagal melakukan checkout!');
    }
  }

  Future cancelCheckout(int id) async {
    var url = '$baseUrl/order/cancel/$id';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(Uri.parse(url), headers: headers);
    print(response.body);
    
    if (response.statusCode == 200) {
      var result = json.encode(response.body);
      return result;
    } else {
      throw Exception('Gagal melakukan pembatalan order !');
    }
  }
}