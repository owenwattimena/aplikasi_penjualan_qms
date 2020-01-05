/// ClientModel.dart
import 'dart:convert';

History historyFromJson(String str) {
  final jsonData = json.decode(str);
  return History.fromMap(jsonData);
}

String historyToJson(History data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class History {
  int id;
  String nama;
  String listPesanan;
  int total;
  int bayar;
  History({
    this.id,
    this.nama,
    this.listPesanan,
    this.total,
    this.bayar,
  });

  factory History.fromMap(Map<String, dynamic> json) => new History(
        id: json["id"],
        nama: json["nama"],
        listPesanan: json["list_pesanan"],
        total: json["total"],
        bayar: json["bayar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "list_pesanan": listPesanan,
        "total": total,
        "bayar": bayar,
      };
}
