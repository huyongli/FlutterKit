
import 'package:flutter/material.dart';

class HomeItem {
  final String title;
  final Function(BuildContext) onTapped;

  HomeItem({required this.title, required this.onTapped});
}