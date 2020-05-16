import 'dart:collection';

import 'package:flutter/material.dart';

class CartItem {
  double price;
  int count;

  CartItem({this.price, this.count});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (value, item) => value + item.count * item.price);

  void add(CartItem item) {
    _items.add(item);
    notifyListeners();
  }
}