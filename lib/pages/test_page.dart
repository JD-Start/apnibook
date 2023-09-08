import 'dart:io';

import 'package:apnibook/services/pdfService.dart';
import 'package:apnibook/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Test_Page extends StatefulWidget {
  const Test_Page({super.key});

  @override
  State<Test_Page> createState() => _Test_PageState();
}

class _Test_PageState extends State<Test_Page> {
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

  setDataInTable(String cid) async {
    List result = await getDataForTable(cid);
    int datalen = result[0];
    List dataList = result[1];
    List listOfDataRows = [];
    // print(datalen);
    // print(dataList);

    for (int i = 0; i < datalen; i++) {
      listOfDataRows.add(
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

    print(listOfDataRows);
    return listOfDataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     setDataInTable('28bf8480-131e-1cc7-a640-ad69b45d9190');
          //   },
          //   child: const Text('get data'),
          // ),
          ElevatedButton(
              onPressed: () async {
                final PdfFile =
                    await PDFService().generateText('Hello My name is JD.');
                PDFService().openFile(PdfFile);
              },
              child: const Text('Generate PDF')),
          ElevatedButton(
              onPressed: () async {
                final PdfFile = await PDFService().generateParagraph();
                PDFService().openFile(PdfFile);
              },
              child: const Text('Generate PDF with Text')),
          ElevatedButton(
              onPressed: () async {
                final dir = await getApplicationDocumentsDirectory();
                print('${dir.path}/hello.pdf');

                Directory directory = Directory('/storage/emulated/0/Download');
                print('directory: ${directory.path}');
                final file = File('${directory.path}/hello.pdf');
                // await file.writeAsBytes(bytes);
                requestStoragePermission(Permission.manageExternalStorage);
                // Create a new PDF document.
                final PdfDocument document = PdfDocument();
                // Add a PDF page and draw text.
                document.pages.add().graphics.drawString('Hello World!',
                    PdfStandardFont(PdfFontFamily.helvetica, 12),
                    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                    bounds: const Rect.fromLTWH(0, 0, 150, 20));
                // Save the document.
                // File('HelloWorld.pdf').writeAsBytes(await document.save());
                file.writeAsBytes(await document.save());
                // Dispose the document.
                document.dispose();
                // PDFService().pdfFunction();
                // // final PdfFile = await PDFService().generateText('hello_pdf');
                // // PDFService().openFile(PdfFile);
              },
              child: const Text('Generate PDF with Table')),
          ElevatedButton(
              onPressed: () async {
                final PdfFile = await PDFService()
                    .generateFile('b69394d0-f722-1ccb-bb0b-93abab86c106');
                PDFService().openFile(PdfFile);
              },
              child: const Text('Generate Main PDF ')),
        ],
      ),
    );
  }
}
