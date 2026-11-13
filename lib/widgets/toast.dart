import 'package:flutter/material.dart';

class Toast {

  BuildContext context;

  Toast(this.context);

  void show(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}