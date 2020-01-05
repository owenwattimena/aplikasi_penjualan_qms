import 'dart:io';
import 'package:aplikasi_penjualan_qms/model/history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "qms.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE history ("
          "id INTEGER PRIMARY KEY,"
          "nama TEXT,"
          "list_pesanan TEXT,"
          "total INTEGER,"
          "bayar INTEGER"
          ")");
    });
  }

  newHistory(History newHistory) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT Into history (id,nama, list_pesanan, total, bayar)"
        " VALUES (${newHistory.id},'${newHistory.nama}', '${newHistory.listPesanan}', ${newHistory.total}, ${newHistory.bayar})");
    return res;
  }

  getAllHistories() async {
    final db = await database;
    var res = await db.query("history");
    List<History> list =
        res.isNotEmpty ? res.map((c) => History.fromMap(c)).toList() : [];
    return list;
  }

  deleteHistory(int id) async {
    final db = await database;
    return await db.rawDelete('DELETE FROM history WHERE id = $id');
  }
}
