import 'package:apnibook/utils.dart';
import 'package:flutter/material.dart';

class ShowStock_widget extends StatelessWidget {
  String text;
  String stockCount;
  String sid;

  ShowStock_widget(
      {super.key,
      required this.text,
      required this.stockCount,
      required this.sid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24),
          boxShadow: shadow,
          border: Border.all(color: Colors.green, width: 1.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/inventory.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              stockCount,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
