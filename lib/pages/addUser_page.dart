import 'package:apnibook/services/firebaseServices.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class AddUser_Page extends StatefulWidget {
  const AddUser_Page({super.key});
  @override
  State<AddUser_Page> createState() => _AddUser_PageState();
}

class _AddUser_PageState extends State<AddUser_Page> {
  String name = '';
  String phone = '';
  String camountPaid = '';
  String camountReceived = '';
  String amountWillGet = '';
  @override
  Widget build(BuildContext context) {
    TextEditingController clientName = TextEditingController();
    TextEditingController clientPhoneNumber = TextEditingController();
    TextEditingController amountPaid = TextEditingController();
    TextEditingController amountReceived = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add new Client',
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
                controller: clientName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 24,
                  ),
                  labelText: 'Client name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: clientPhoneNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.phone,
                    size: 24,
                  ),
                  labelText: 'Client Phone number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: amountPaid,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    // Icons.outbox_rounded,
                    Icons.file_upload_outlined,
                    size: 24,
                  ),
                  labelText: 'Amount Paid till now',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: amountReceived,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount Received till now',
                  prefixIcon: const Icon(
                    // Icons.install_mobile_rounded,
                    Icons.file_download_outlined,
                    size: 24,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    name = clientName.text;
                    phone = clientPhoneNumber.text;
                    camountPaid = amountPaid.text;
                    camountReceived = amountReceived.text;
                    amountWillGet = (int.parse(amountPaid.text) -
                            int.parse(amountReceived.text))
                        .toString();
                  });
                },
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(8),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade300),
                  fixedSize: MaterialStateProperty.all(const Size(240, 30)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  'Calculate amount you will get',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              amountWillGet == ''
                  ? const SizedBox.shrink()
                  : Text(
                      'Amount you will get: $amountWillGet',
                      style: const TextStyle(
                        fontSize: 14,
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
                      if (clientName.text != '' && amountPaid.text != '') {
                        FirebaseServices().addNewUser(
                            clientName.text != '' ? clientName.text : name,
                            clientPhoneNumber.text != ''
                                ? clientPhoneNumber.text
                                : phone,
                            amountPaid: amountPaid.text != ''
                                ? amountPaid.text
                                : camountPaid,
                            amountReceived: amountReceived.text != ''
                                ? amountReceived.text
                                : camountReceived,
                            amountWillGet: amountPaid.text != ''
                                ? (int.parse(amountPaid.text) -
                                        int.parse(amountReceived.text))
                                    .toString()
                                : amountWillGet);
                        DisplaySnackBar(
                            context, 'Client added', Colors.green.shade300);
                      } else {
                        DisplaySnackBar(context, 'Please fill  details',
                            Colors.red.shade300);
                      }
                    },
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(8),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.green.shade300),
                      fixedSize: MaterialStateProperty.all(const Size(110, 30)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      '+ Add user',
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
