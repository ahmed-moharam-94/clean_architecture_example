import 'package:flutter/material.dart';

class SnackBarMessage {
  void showSuccessSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
          content: Text(message, style: const TextStyle(color: Colors.white))));

  void showErrorSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(message, style: const TextStyle(color: Colors.white))));
}
