import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String message,
  Color bgColor = Colors.green,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: bgColor,
    ));
}
