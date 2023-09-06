import 'package:apnibook/services/firebaseServices.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class AddStock_Page extends StatefulWidget {
  const AddStock_Page({super.key});
  @override
  State<AddStock_Page> createState() => _AddStock_PageState();
}

class _AddStock_PageState extends State<AddStock_Page> {
  @override
  Widget build(BuildContext context) {
    TextEditingController stockName = TextEditingController();
    TextEditingController stockAmount = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add new Stock',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: stockName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.inventory,
                    size: 24,
                  ),
                  labelText: 'Stock Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: stockAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.format_list_numbered_sharp,
                    size: 24,
                  ),
                  labelText: 'Stock Amount',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (stockName.text != '' && stockAmount.text != '') {
                        FirebaseServices()
                            .addNewStock(stockName.text, stockAmount.text);
                        DisplaySnackBar(
                            context, 'Stock added', Colors.green.shade300);
                      } else {
                        DisplaySnackBar(context, 'Please fill all details',
                            Colors.red.shade300);
                      }
                    },
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(8),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.green.shade300),
                      fixedSize: MaterialStateProperty.all(const Size(130, 30)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      '+ Add Stock',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(8),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade300),
                      fixedSize: MaterialStateProperty.all(const Size(110, 30)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
