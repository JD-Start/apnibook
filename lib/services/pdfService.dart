import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart%20';

class tempModel {
  String a;
  String b;
  String c;

  tempModel({
    required this.a,
    required this.b,
    required this.c,
  });
}

getListToMap(int length) {}
convertToTempModel(List<dynamic> m, int length) {
  List listOfTempModel = [];
  for (int i = 0; i < length; i++) {
    // listOfTempModel.add(tempModel(a: m[i], b: m[i], c: m[i]));
    listOfTempModel.addAll([m[i]].toList());
    // for (int j = 0; i < 3; j++) {
    // }
  }
  print(listOfTempModel);
  print(listOfTempModel.runtimeType);
  final finalRows = [...listOfTempModel];
  print(finalRows.runtimeType);

  // return listOfTempModel;
  return finalRows;
}

class PDFService {
  Future<File> generateText(String text) async {
    final pdf = Document();
    pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Center(
          child: Text(
            text,
            style: const TextStyle(),
          ),
        );
      },
    ));
    return saveDocument(name: 'simple_text.pdf', pdf: pdf);
  }

  Future<List> getClientInfo(String cid) async {
    List listToReturn = [];
    DocumentSnapshot oldData =
        await FirebaseFirestore.instance.collection('clients').doc(cid).get();
    var temp = oldData.data() as Map<String, dynamic>;
    String name = temp['name'];
    String phone = temp['phoneNumber'];
    String paid = temp['amountPaid'];
    String received = temp['amountReceived'];
    String pending = temp['amountWillGet'];
    listToReturn.add(name);
    listToReturn.add(phone);
    listToReturn.add(paid);
    listToReturn.add(received);
    listToReturn.add(pending);
    return listToReturn;
  }

  generateFile(String cid) async {
    var result = await getDataForTable(cid);
    List dump = await getClientInfo(cid);
    String name = dump[0];
    String phone = dump[1];
    String paid = dump[2];
    String received = dump[3];
    String pending = dump[4];

    int len = result[0];
    // List temp = result[1];
    // final data = convertToTempModel(temp, len);
    // print('---${data.runtimeType}');
    print('len: $len');

    // final listOFTempModel = await getDataForTableIntoTempModelList(
    //     'b69394d0-f722-1ccb-bb0b-93abab86c106');
    // final TT = listOFTempModel
    //     .map((tempModel) => [tempModel.a, tempModel.b, tempModel.c])
    //     .toList();
    // tempClass().getListToMap();
    // List<List<dynamic>> data = [];

    // print(result.runtimeType);
    // print(result);
    // print(temp);

    // data[0][0] = [temp[0][0]];
    // print('data: ${data.runtimeType}');
    // data[[0][0]] = temp[0][0];

    // for (int i = 0; i < len; i++) {
    //   data[[0][0]] = temp[0][0];
    //   data[[0][0]] = temp[0][0];
    // }

    // print(data);
    // final header = ['Amount Received', 'Amount Paid', 'Amount Pending'];
    // final rowData = [
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    //   ['Amount Received', 'Amount Paid', 'Amount Pending'],
    // ];

    List<TableRow> data = await getRowDataInTableRow(cid);
    print(data);
    TableRow firstRow = TableRow(
      decoration: const BoxDecoration(color: PdfColor.fromInt(0xFFB0B4BF)),
      children: [
        Text(
          'Date and Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Paid',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Received',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    data.insert(0, firstRow);
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        Divider(thickness: 1.5, color: const PdfColor.fromInt(0xFF99B0BF)),
        SizedBox(
          height: 1.5,
        ),
        Header(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(5),
              color: PdfColor.fromInt(0xFFEC6443),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Client Transaction Report',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Client name: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Client number: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: phone,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Date: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Amount Paid: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: paid,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Amount Received: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: received,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Amount Pending',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: pending,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // Table.fromTextArray(
        //   headers: header,
        //   data: rowData,
        //   border: const TableBorder(
        //       top: BorderSide(width: 2),
        //       bottom: BorderSide(width: 2),
        //       horizontalInside: BorderSide(width: 1)),
        //   headerAlignment: Alignment.center,
        //   cellAlignment: Alignment.center,
        //   columnWidths: {
        //     0: const IntrinsicColumnWidth(flex: 1.5),
        //     1: const IntrinsicColumnWidth(flex: 1),
        //     2: const IntrinsicColumnWidth(flex: 1.3)
        //   },
        //   headerAlignments: {
        //     0: Alignment.center,
        //     1: Alignment.center,
        //     2: Alignment.center
        //   },
        //   headerStyle: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: PdfColors.white),
        //   headerCellDecoration: const BoxDecoration(
        //     color: PdfColor.fromInt(0xFFB0B4BF),
        //   ),
        // ),
        Table(
          columnWidths: {
            0: const IntrinsicColumnWidth(flex: 1.5),
            1: const IntrinsicColumnWidth(flex: 1),
            2: const IntrinsicColumnWidth(flex: 1.3)
          },
          border: const TableBorder(
            bottom: BorderSide(width: 1.5),
            top: BorderSide(width: 1.5),
            horizontalInside: BorderSide(width: 1),
          ),
          children: data,
        ),
        SizedBox(
          height: 5,
        ),
        Divider(thickness: 1.5, color: const PdfColor.fromInt(0xFF99B0BF)),
        Footer(
          padding: const EdgeInsets.all(3),
          title: Text(
            textAlign: TextAlign.center,
            'Report is Auto-generated for $name on ${DateTime.now()} by ApniBook app.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
        )
      ],
    ));
    return saveDocument(
        name: '${name}_${DateFormat('yyyy-MM-dd').format(DateTime.now())}.pdf',
        pdf: pdf);
  }

  getRowDataInTableRow(String cid) async {
    List returnValues = [];
    List<TableRow> dataList = [];
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
      dataList.add(
        TableRow(
          children: [
            Text(
              dataForTable.docs[i]['dateTime'].replaceAll(' ', '__').toString(),
            ),
            Text(
              dataForTable.docs[i]['paid'].toString(),
            ),
            Text(
              dataForTable.docs[i]['received'].toString(),
            ),
          ],
          // a: dataForTable.docs[i]['dateTime'].replaceAll(' ', '__').toString(),
          // b: dataForTable.docs[i]['paid'].toString(),
          // c: dataForTable.docs[i]['received'].toString(),
        ),
      );
    }

    // returnValues.add(dataList);
    // print(dataList);
    return dataList;
  }

  generateParagraph() async {
    List<TableRow> data =
        await getRowDataInTableRow('b69394d0-f722-1ccb-bb0b-93abab86c106');
    print(data);
    TableRow firstRow = TableRow(
      decoration: const BoxDecoration(color: PdfColor.fromInt(0xFFB0B4BF)),
      children: [
        Text(
          'Date and Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Paid',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Received',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    data.insert(0, firstRow);

    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          Header(
            child: Text(
              'This is PDF',
              style: const TextStyle(fontSize: 14, color: PdfColors.red),
            ),
          ),
          Paragraph(text: LoremText().paragraph(100)),
          Paragraph(text: LoremText().paragraph(50)),
          Table(
            columnWidths: {
              0: const IntrinsicColumnWidth(flex: 1.5),
              1: const IntrinsicColumnWidth(flex: 1),
              2: const IntrinsicColumnWidth(flex: 1.3)
            },
            border: const TableBorder(
              bottom: BorderSide(width: 1.5),
              top: BorderSide(width: 1.5),
              horizontalInside: BorderSide(width: 1),
            ),
            children: data,
          ),
        ],
      ),
    );
    return saveDocument(name: 'paragraph2.pdf', pdf: pdf);
  }

  Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();

    final dir = Directory('/storage/emulated/0/Download');

    print('dir: $dir');
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
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
      dataList.add([
        dataForTable.docs[i]['dateTime'].replaceAll(' ', '__').toString(),
        dataForTable.docs[i]['paid'].toString(),
        dataForTable.docs[i]['received'].toString(),
      ]);
    }
    returnValues.add(dataList);
    // returnValues.add(dataList);
    // print(dataList);
    return returnValues;
  }

  getDataRowsList(String cid) async {
    List result = getDataForTable(cid);
    int datalen = result[0];
    List dataList = result[1];
    // List<DataRow> listDatarows = [];
    // // print(datalen);
    // // print(dataList);

    // for (int i = 0; i < datalen; i++) {
    //   listDatarows.add(
    //     DataRow(
    //       cells: [
    //         DataCell(
    //           Text(dataList[i]['dateTime']),
    //         ),
    //         DataCell(
    //           Text(dataList[i]['paid']),
    //         ),
    //         DataCell(
    //           Text(dataList[i]['received']),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    // // print('---');
    // // print(listDatarows);
    // setState(() {
    //   listOfDataRows = listDatarows;
    // });
    // // print('+++');
    // // print(listOfDataRows);
  }

  getDataForTableIntoTempModelList(String cid) async {
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
      dataList.add(
        tempModel(
          a: dataForTable.docs[i]['dateTime'].replaceAll(' ', '__').toString(),
          b: dataForTable.docs[i]['paid'].toString(),
          c: dataForTable.docs[i]['received'].toString(),
        ),
      );
    }

    // returnValues.add(dataList);
    // print(dataList);
    return dataList;
  }
}
