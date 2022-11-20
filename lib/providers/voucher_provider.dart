import 'package:flutter/cupertino.dart';
import 'package:fooder/models/voucher_model.dart';
import 'package:fooder/services/voucher_services.dart';

class VoucherProvider with ChangeNotifier {
  List<VoucherModel> _vouchers = [];
  List<VoucherModel> get vouchers => _vouchers;
  set vouchers(List<VoucherModel> vouchers) {
    _vouchers = vouchers;
    notifyListeners();
  }

  String _voucherCode = "";

  String get getVoucherCode => _voucherCode;

  saveVoucher(String voucherCode) {
    _voucherCode = voucherCode;
    notifyListeners();
  }

  diskonHarga() {
    double diskon = 0;
    for (var item in _vouchers) {
      if (getVoucherCode == item.kode) {
        diskon += item.nominal;
      } 
    }

    return diskon;
  }

  deleteDiskon(){
    _voucherCode = '';
    notifyListeners();
  }

  Future<void> getVoucher() async {
    try {
      List<VoucherModel> vouchers = await VoucherService().getVoucher();
      _vouchers = vouchers;
    } catch (e) {
      print(e);
    }
  }
}
