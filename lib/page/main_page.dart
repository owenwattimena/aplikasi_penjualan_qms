import 'package:aplikasi_penjualan_qms/model/history.dart';
import 'package:aplikasi_penjualan_qms/module/database.dart';
import 'package:aplikasi_penjualan_qms/page/list_page.dart';
import 'package:aplikasi_penjualan_qms/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nama = new TextEditingController();
  TextEditingController _bayar = new TextEditingController();
  bool esKelapa = false;
  bool esTeler = false;
  Map daftarPesanan = {
    'RW': 0,
    'Ayam Panggang': 0,
    'Salad': 0,
  };

  int total = 0;
  int kembali = 0;

  @override
  void initState() {
    super.initState();
    // _bayar.text = 0.toString();
  }

  pesan() async {
    //A
    if (total == 0) {
      //B
      Toast.show("Tekan Tombol Proses Terlebih dahulu", context, //C
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
      return;
    } //D
    if (kembali < 0) {
      //E
      Toast.show("Uang Kurang!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM); //F
      return;
    } //G

    String pesanan = ""; //H

    if (daftarPesanan['RW'] != 0) {
      //I
      int jumlah = daftarPesanan['RW'];
      pesanan += "RW - " + jumlah.toString(); //J
    } //K

    if (daftarPesanan['Ayam Panggang'] != 0) {
      //L
      int jumlah = daftarPesanan['Ayam Panggang'];
      pesanan += "~Ayam Panggang - " + jumlah.toString(); //M
    } else {
      //N
      pesanan += '~'; //O
    } //P
    if (daftarPesanan['Salad'] != 0) {
      //L
      int jumlah = daftarPesanan['Salad'];
      pesanan += "~Salad - " + jumlah.toString(); //M
    } else {
      //N
      pesanan += '~'; //O
    } //P
    await DBProvider.db.newHistory(
      new History(
        nama: _nama.text,
        listPesanan: pesanan,
        total: total,
        bayar: int.parse(_bayar.text),
      ),
    ); //P
    Toast.show("Transaksi Berhasil", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM); //Q
    reset(); //R
    // dispose();
  } //S

  reset() {
    _nama.text = '';
    _bayar.text = '';
    // setState(() {
    //   this.total = 0;
    //   this.kembali = 0;
    // });
  }

  infoApp() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info Aplikasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Quality Management System.'),
                Text('\"Onaki Food!\"'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text('Oleh TI C semester 7 POLNAM'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Frelly R Parinussa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '1316144060',
                  style: TextStyle(fontSize: 14),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Fianus Maxi Frandy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '1316144083',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('Ok')],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onaki Food"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              infoApp();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Text("Menu"),
              CardWidget(
                asset: "assets/img/rw.jpg",
                menu: "RW - Rp. 10.000",
                harga: 10000,
                total: this.total,
                curentOrder: daftarPesanan['RW'],
                order: (order, _total) {
                  setState(() {
                    daftarPesanan['RW'] = order;
                    this.total = _total;
                    if (_bayar.text.isEmpty) {
                      this.kembali = 0 - this.total;
                    } else {
                      this.kembali = int.parse(_bayar.text) - this.total;
                    }
                  });
                },
              ),
              CardWidget(
                asset: "assets/img/ayam_panggang.jpg",
                menu: "Ayam Panggang - Rp. 10.000",
                harga: 10000,
                total: this.total,
                curentOrder: daftarPesanan['Ayam Panggang'],
                order: (order, _total) {
                  setState(() {
                    daftarPesanan['Ayam Panggang'] = order;
                    this.total = _total;
                    if (_bayar.text.isEmpty) {
                      this.kembali = 0 - this.total;
                    } else {
                      this.kembali = int.parse(_bayar.text) - this.total;
                    }
                  });
                },
              ),
              CardWidget(
                asset: "assets/img/salad.jpg",
                menu: "Salad - Rp. 10.000",
                harga: 10000,
                total: this.total,
                curentOrder: daftarPesanan['Salad'],
                order: (order, _total) {
                  setState(() {
                    daftarPesanan['Salad'] = order;
                    this.total = _total;
                    if (_bayar.text.isEmpty) {
                      this.kembali = 0 - this.total;
                    } else {
                      this.kembali = int.parse(_bayar.text) - this.total;
                    }
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$total",
                  style: TextStyle(fontSize: 35),
                ),
              ),
              TextFormField(
                controller: _bayar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Bayar',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    this.kembali = int.parse(value) - this.total;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan jumlah nominal yang sesuai';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 8)),

              TextFormField(
                controller: _nama,
                decoration: InputDecoration(
                  labelText: 'Nama Pembeli',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan Nama Pembeli';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Kembali"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$kembali",
                  style: TextStyle(fontSize: 35),
                ),
              ),
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("Pesan"),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    pesan();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
