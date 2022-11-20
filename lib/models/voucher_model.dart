class VoucherModel {
  late int id;
  late String kode;
  late double nominal;
  

  VoucherModel({
    required this.id,
    required this.kode,
    required this.nominal,
  });

   VoucherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nominal = double.parse(json['nominal'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'nominal': nominal,
    };
  }

  
}