import 'package:apnibook/services/firebaseServices.dart';
import 'package:apnibook/utils.dart';
import 'package:apnibook/widgets/transaction_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientDetails_Page extends StatefulWidget {
  final snap;
  const ClientDetails_Page({super.key, required this.snap});

  @override
  State<ClientDetails_Page> createState() => _ClientDetails_PageState();
}

class _ClientDetails_PageState extends State<ClientDetails_Page> {
  Map<String, dynamic> mapFortable = {};
  dynamic tableSnap;

  showDialogToMakePayement() {
    TextEditingController payTextField = TextEditingController();
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Make payment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: payTextField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                size: 24,
              ),
              hintText: "Enter payment amount",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: InkWell(
                onTap: () {
                  FirebaseServices().payToClient(widget.snap['cid'],
                      payTextField.text, DateTime.now().toString());
                  DisplaySnackBar(
                      context, 'Payment done', Colors.green.shade300);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CupertinoDialogAction(
                child: Text(
                  'No',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  showDialogtoRequestPayment() {
    TextEditingController requestPayTextField = TextEditingController();
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            'Request payment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: requestPayTextField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                size: 24,
              ),
              hintText: "Enter Request payment amount",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: InkWell(
                onTap: () {
                  FirebaseServices().requestPayment(widget.snap['cid'],
                      requestPayTextField.text, DateTime.now().toString());
                  DisplaySnackBar(
                      context, 'Payment request done', Colors.green.shade300);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Request payment',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CupertinoDialogAction(
                child: Text(
                  'No',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  getData(String cid) async {
    print('@@@');
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('clients')
        .doc(cid)
        .collection('transactions')
        .get();

    // List docs = snapshot.docs;
    // for (var doc in docs) {
    //   print(doc.id);
    // }
    // print(docs[0]);
  }

  List getRowData(QuerySnapshot snapshot) {
    print('+++++');
    List rowDataList = snapshot.docs.map(
      (DocumentSnapshot documentSnapshot) {
        return DataRow(
          cells: [
            DataCell(Text(documentSnapshot['dateTime'].toString())),
            DataCell(Text(documentSnapshot['paid'].toString())),
            DataCell(Text(documentSnapshot['received'].toString())),
          ],
        );
      },
    ).toList();
    print(rowDataList);
    return rowDataList;
  }

  getDataForTable(String cid) {
    print(cid);
    print('---');
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('clients')
          .doc(cid)
          .collection('transactions')
          .snapshots(),
      builder: (context, snapshot) {
        List rowDataList = (snapshot.data! as dynamic).docs.map(
          (DocumentSnapshot documentSnapshot) {
            return DataRow(
              cells: [
                DataCell(Text(documentSnapshot['dateTime'].toString())),
                DataCell(Text(documentSnapshot['paid'].toString())),
                DataCell(Text(documentSnapshot['received'].toString())),
              ],
            );
          },
        ).toList();
        print(rowDataList);
        // print('>>>>');
        // getRowData(snapshot.data as QuerySnapshot<Object?>);
        // // tableSnap = snapshot.data;
        // tableSnap = snapshot.data!.docs[1].data()['paid'];
        // print(tableSnap);
        // // print(snapshot.data);
        // // return const SizedBox.shrink();

        // int dataLength = snapshot.data!.docs.length;
        // for (int i = 0; i < dataLength; i++) {
        //   print(snapshot.data!.docs[i].data()['cid']);
        //   // print(i);
        // }
        return const SizedBox.shrink();
        //  DataTable(columns: const [
        //   DataColumn(
        //     label: Text('a'),
        //   ),
        //   DataColumn(label: Text('b')),
        //   DataColumn(label: Text('c')),
        // ], rows: const []
        //     // snapshot.data.docs.
        //     //     .map(
        //     //       (entry) => DataRow(
        //     //         cells: [
        //     //           DataCell(Text(entry.key.toString())),
        //     //           DataCell(Text(entry.value.toString()))
        //     //         ],
        //     //       ),
        //     //     )
        //     //     .toList(),
        //     );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/330px-User_icon_2.svg.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.snap['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Transcation_widget(
                        transactionType: 'Total Received',
                        amount: widget.snap['amountReceived'],
                        isPaid: true),
                    Transcation_widget(
                        transactionType: 'Total Paid',
                        amount: widget.snap['amountPaid'],
                        isPaid: false),
                    Transcation_widget(
                        transactionType: 'Amount pending',
                        amount: widget.snap['amountWillGet'],
                        isPaid: true),
                  ],
                ),
                DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Date & Time',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Received',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Paid',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '13 feb 2008',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          // tableSnap['paid'],
                        ),
                        DataCell(
                          Text('0'),
                        ),
                        DataCell(
                          Text('1000'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text('8 jul 2011'),
                        ),
                        DataCell(
                          Text('658'),
                        ),
                        DataCell(
                          Text('0'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text('27 dec 2015'),
                        ),
                        DataCell(
                          Text('0'),
                        ),
                        DataCell(
                          Text('10000'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text('18 jul  2017'),
                        ),
                        DataCell(
                          Text('4000'),
                        ),
                        DataCell(
                          Text('0'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text('3 aug 2019'),
                        ),
                        DataCell(
                          Text('0'),
                        ),
                        DataCell(
                          Text('7500'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () {
                    showDialogToMakePayement();
                    // FirebaseServices().payToClient(
                    //     '2d3fb200-162a-1cc7-8f43-01a86b135bda', '4631', '463');
                    // DisplaySnackBar(
                    //     context, 'Payment done', Colors.green.shade300);
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
                    'Pay',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: () {
                    showDialogtoRequestPayment();
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(8),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.green.shade300),
                    fixedSize: MaterialStateProperty.all(const Size(150, 30)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Request payment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // getDataForTable(widget.snap['cid']);
                      getData(widget.snap['cid']);
                    },
                    icon: Icon(
                      Icons.picture_as_pdf,
                      size: 30,
                      color: Colors.red.shade300,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
