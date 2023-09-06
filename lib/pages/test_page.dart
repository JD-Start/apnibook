import 'package:apnibook/services/firebaseServices.dart';
import 'package:flutter/material.dart';

class Test_Page extends StatelessWidget {
  const Test_Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              FirebaseServices().addNewUser('JJ', '99665',
                  amountPaid: '15456',
                  amountReceived: '544',
                  amountWillGet: '91312');
            },
            child: const Text('Add new User'),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseServices().addNewStock('laptop', '24');
            },
            child: const Text('Add new Stock'),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseServices()
                  .removeClient('3a5b2d00-bd2b-1cc6-87dc-2d09e7eb8d49');
            },
            child: const Text('Remove User'),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseServices()
                  .removeStock('2f9aa980-bdb8-1cc6-a729-6be60e022092');
            },
            child: const Text('Remove Stock'),
          ),
        ],
      ),
    );
  }
}
