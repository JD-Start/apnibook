import 'package:apnibook/services/firebaseServices.dart';
import 'package:apnibook/services/pdfService.dart';
import 'package:apnibook/utils.dart';
import 'package:apnibook/widgets/transaction_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ClientDetails_Page extends StatefulWidget {
  final snap;
  const ClientDetails_Page({super.key, required this.snap});

  @override
  State<ClientDetails_Page> createState() => _ClientDetails_PageState();
}

class _ClientDetails_PageState extends State<ClientDetails_Page> {
  String amountPaid = '';
  String amountReceived = '';
  String amountPending = '';
  Map<String, dynamic> mapFortable = {};
  dynamic tableSnap;
  List<DataRow> listOfDataRows = [];
  @override
  void initState() {
    super.initState();
    amountPaid = widget.snap['amountPaid'];
    amountReceived = widget.snap['amountReceived'];
    amountPending = widget.snap['amountWillGet'];
    setState(() {
      getDataRowsList(widget.snap['cid']);
    });
    // print(temp);
  }

  getDataForTable(String cid) async {
    List returnValues = [];
    List dataList = [];
    QuerySnapshot<Map<String, dynamic>> dataForTable = await FirebaseFirestore
        .instance
        .collection('clients')
        .doc(cid)
        .collection('transactions')
        .get();
    int datalen = dataForTable.docs.length;
    returnValues.add(datalen);
    // print(datalen);
    for (int i = 0; i < datalen; i++) {
      dataList.add({
        'dateTime': dataForTable.docs[i]['dateTime'],
        'paid': dataForTable.docs[i]['paid'],
        'received': dataForTable.docs[i]['received']
      });
    }
    returnValues.add(dataList);
    // print(dataList);
    return returnValues;
  }

  getDataRowsList(String cid) async {
    List result = await getDataForTable(cid);
    int datalen = result[0];
    List dataList = result[1];
    List<DataRow> listDatarows = [];
    // print(datalen);
    // print(dataList);

    for (int i = 0; i < datalen; i++) {
      listDatarows.add(
        DataRow(
          cells: [
            DataCell(
              Text(dataList[i]['dateTime']),
            ),
            DataCell(
              Text(dataList[i]['paid']),
            ),
            DataCell(
              Text(dataList[i]['received']),
            ),
          ],
        ),
      );
    }
    // print('---');
    // print(listDatarows);
    setState(() {
      listOfDataRows = listDatarows;
    });
    // print('+++');
    // print(listOfDataRows);
  }

  refreshClientInfo() async {
    // Future.wait(getDataRowsList(widget.snap['cid']));
    await getDataRowsList(widget.snap['cid']);
    List result =
        await FirebaseServices().refreshClientInfo(widget.snap['cid']);
    setState(() {
      amountPaid = result[0];
      amountReceived = result[1];
      amountPending = result[2];
    });
  }

  payToClient(String cid, String amount) async {
    await FirebaseServices()
        .payToClient(cid, amount, DateTime.now().toString());
    refreshClientInfo();
  }

  requestToClient(String cid, String amount) async {
    await FirebaseServices()
        .requestPayment(cid, amount, DateTime.now().toString());
    refreshClientInfo();
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      payToClient(widget.snap['cid'], payTextField.text);
                      // FirebaseServices().payToClient(widget.snap['cid'],
                      //     payTextField.text, DateTime.now().toString());

                      // getDataRowsList(widget.snap['cid']);
                      Navigator.pop(context);

                      // Future.delayed(
                      //     const Duration(milliseconds: 1200), refreshClientInfo());
                      DisplaySnackBar(
                          context, 'Payment done', Colors.green.shade300);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      requestToClient(
                          widget.snap['cid'], requestPayTextField.text);
                      // FirebaseServices().requestPayment(widget.snap['cid'],
                      //     requestPayTextField.text, DateTime.now().toString());
                      // getDataRowsList(widget.snap['cid']);
                      // refreshClientInfo();
                      Navigator.pop(context);
                      DisplaySnackBar(context, 'Payment request done',
                          Colors.green.shade300);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // getData(String cid) async {
  //   print('@@@');
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //       .instance
  //       .collection('clients')
  //       .doc(cid)
  //       .collection('transactions')
  //       .get();

  //   // List docs = snapshot.docs;
  //   // for (var doc in docs) {
  //   //   print(doc.id);
  //   // }
  //   // print(docs[0]);
  // }

  // List getRowData(QuerySnapshot snapshot) {

  //   List rowDataList = snapshot.docs.map(
  //     (DocumentSnapshot documentSnapshot) {
  //       return DataRow(
  //         cells: [
  //           DataCell(Text(documentSnapshot['dateTime'].toString())),
  //           DataCell(Text(documentSnapshot['paid'].toString())),
  //           DataCell(Text(documentSnapshot['received'].toString())),
  //         ],
  //       );
  //     },
  //   ).toList();
  //   print(rowDataList);
  //   return rowDataList;
  // }

  // getDataForTable(String cid) {
  //   print(cid);
  //   print('---');
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance
  //         .collection('clients')
  //         .doc(cid)
  //         .collection('transactions')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       List rowDataList = (snapshot.data! as dynamic).docs.map(
  //         (DocumentSnapshot documentSnapshot) {
  //           return DataRow(
  //             cells: [
  //               DataCell(Text(documentSnapshot['dateTime'].toString())),
  //               DataCell(Text(documentSnapshot['paid'].toString())),
  //               DataCell(Text(documentSnapshot['received'].toString())),
  //             ],
  //           );
  //         },
  //       ).toList();
  //       print(rowDataList);
  //       // print('>>>>');
  //       // getRowData(snapshot.data as QuerySnapshot<Object?>);
  //       // // tableSnap = snapshot.data;
  //       // tableSnap = snapshot.data!.docs[1].data()['paid'];
  //       // print(tableSnap);
  //       // // print(snapshot.data);
  //       // // return const SizedBox.shrink();

  //       // int dataLength = snapshot.data!.docs.length;
  //       // for (int i = 0; i < dataLength; i++) {
  //       //   print(snapshot.data!.docs[i].data()['cid']);
  //       //   // print(i);
  //       // }
  //       return const SizedBox.shrink();
  //       //  DataTable(columns: const [
  //       //   DataColumn(
  //       //     label: Text('a'),
  //       //   ),
  //       //   DataColumn(label: Text('b')),
  //       //   DataColumn(label: Text('c')),
  //       // ], rows: const []
  //       //     // snapshot.data.docs.
  //       //     //     .map(
  //       //     //       (entry) => DataRow(
  //       //     //         cells: [
  //       //     //           DataCell(Text(entry.key.toString())),
  //       //     //           DataCell(Text(entry.value.toString()))
  //       //     //         ],
  //       //     //       ),
  //       //     //     )
  //       //     //     .toList(),
  //       //     );
  //     },
  //   );
  // }

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
      body: SingleChildScrollView(
        child: Padding(
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
                          amount: amountReceived,
                          isPaid: true),
                      Transcation_widget(
                          transactionType: 'Total Paid',
                          amount: amountPaid,
                          isPaid: false),
                      Transcation_widget(
                          transactionType: 'Amount pending',
                          amount: amountPending,
                          isPaid: true),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                      dividerThickness: 2,
                      headingRowHeight: 25,
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                      dataRowHeight: 33,
                      border: TableBorder(
                        horizontalInside: const BorderSide(width: 1.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Date & Time',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Paid',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Received',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: listOfDataRows,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      clipBehavior: Clip.antiAlias,
                      onPressed: () {
                        showDialogToMakePayement();
                      },
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(8),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.red.shade300),
                        fixedSize:
                            MaterialStateProperty.all(const Size(110, 30)),
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
                        fixedSize:
                            MaterialStateProperty.all(const Size(150, 30)),
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
                      onPressed: () async {
                        requestStoragePermission(
                            Permission.manageExternalStorage);
                        final PdfFile =
                            await PDFService().generateFile(widget.snap['cid']);
                        PDFService().openFile(PdfFile);
                      },
                      icon: Icon(
                        Icons.picture_as_pdf,
                        size: 30,
                        color: Colors.red.shade300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
