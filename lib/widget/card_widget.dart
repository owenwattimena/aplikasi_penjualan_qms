import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String asset;
  final String menu;
  final int harga;
  final int total;
  final int curentOrder;
  final void Function(int, int) order;

  const CardWidget(
      {Key key,
      this.asset,
      this.menu,
      this.order,
      this.total,
      this.harga,
      this.curentOrder})
      : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    int order = widget.curentOrder;
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Image.asset(widget.asset),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "${widget.menu}",
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 30,
                  child: RaisedButton(
                    child: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (order != 0) {
                          order -= 1;
                          int total = widget.total - widget.harga;
                          widget.order(order, total);
                        }
                      });
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(order.toString())),
                ButtonTheme(
                  minWidth: 30,
                  child: RaisedButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        order += 1;
                        int total = widget.total + widget.harga;
                        widget.order(order, total);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
