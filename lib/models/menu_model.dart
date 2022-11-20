import 'package:fooder/models/voucher_model.dart';

class MenuModel {
  late int id;
  late String nama;
  late double harga;
  late String gambar;
  late int quantity=0;
  late String catatan='' ;
  

  MenuModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.quantity,
    required this.catatan
  });

   MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = double.parse(json['harga'].toString());
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'gambar': gambar,
      'catatan': catatan,
    };
  }

}