import 'package:flutter/material.dart';

class HomePageMenu_Widget extends StatelessWidget {
  String imagePath;
  String text;
  HomePageMenu_Widget({super.key, required this.imagePath, required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green, width: 1.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
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
          ],
        ),
      ),
    );
  }
}
