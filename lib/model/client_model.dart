import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String cid;
  String name;
  String phoneNumber;
  String amountPaid;
  String amountReceived;
  String amountWillGet;

  ClientModel({
    required this.cid,
    required this.name,
    required this.phoneNumber,
    this.amountPaid = '',
    this.amountReceived = '',
    this.amountWillGet = '',
  });

  Map<String, dynamic> convertToJson() {
    return {
      'cid': cid,
      'name': name,
      'phoneNumber': phoneNumber,
      'amountPaid': amountPaid,
      'amountReceived': amountReceived,
      'amountWillGet': amountWillGet,
    };
  }

  static ClientModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ClientModel(
      cid: snapshot['cid'],
      name: snapshot['name'],
      phoneNumber: snapshot['phoneNumber'],
      amountPaid: snapshot['amountPaid'],
      amountReceived: snapshot['amountReceived'],
      amountWillGet: snapshot['amountWillGet'],
    );
  }
}
