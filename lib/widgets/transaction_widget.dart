import 'package:flutter/material.dart';

class Transcation_widget extends StatelessWidget {
  String transactionType;
  String amount;
  bool isPaid = false;
  Transcation_widget(
      {super.key,
      required this.transactionType,
      required this.amount,
      required this.isPaid});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isPaid ? Colors.green : Colors.red, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            transactionType,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.center,
            amount,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isPaid ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
