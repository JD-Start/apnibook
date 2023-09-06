import 'package:cloud_firestore/cloud_firestore.dart';

class StockModel {
  String sId;
  String stockName;
  String stockCount;

  StockModel(
      {required this.sId, required this.stockName, required this.stockCount});

  Map<String, dynamic> convertToJson() {
    return {
      'sId': sId,
      'stockName': stockName,
      'stockCount': stockCount,
    };
  }

  static StockModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return StockModel(
        sId: snapshot['stockName'],
        stockName: snapshot['stockName'],
        stockCount: snapshot['stockAmount']);
  }
}
