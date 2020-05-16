import 'package:flutter/material.dart';

import 'cart.dart';
import 'provider/change_notifier_provider.dart';
import 'provider/consumer.dart';

class CartWidget extends StatefulWidget {

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Provider Demo'),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(builder: (context) => Consumer<CartModel>(
                builder: (context, cart) => Text('总价：${cart.totalPrice}'),
              )),
              Builder(builder: (context) {
                print('RaiseButton Build');
                return RaisedButton(
                    child: Text('添加商品'),
                    onPressed: () {
                      ChangeNotifierProvider.of<CartModel>(context, listen: false).add(CartItem(price: 20, count: 1));
                    }
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
