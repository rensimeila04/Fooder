import 'dart:convert';
import 'package:fooder/models/voucher_model.dart';
import 'package:http/http.dart' as http;

class VoucherService {
  String baseUrl = 'https://tes-mobile.landa.id/api';

  Future<List<VoucherModel>> getVoucher() async {
    var url = '$baseUrl/vouchers';

    var response = await http.get(Uri.parse(url));

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['datas'];
      List<VoucherModel> vouchers = [];

      for (var item in data) {
        vouchers.add(VoucherModel.fromJson(item));
      }

      return vouchers;
    } else {
      throw Exception('Gagal mendapatkan data!');
    }
  }
}
