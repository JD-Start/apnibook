import 'package:flutter/material.dart';

class SampleWidget extends StatelessWidget {
  const SampleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: const Center(
            child: Text(
              'Sample widget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
