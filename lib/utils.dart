import 'package:flutter/material.dart';

DisplaySnackBar(BuildContext context, String content, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
    ),
  );
}
