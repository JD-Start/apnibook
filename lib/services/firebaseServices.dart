import 'package:apnibook/model/client_model.dart';
import 'package:apnibook/model/stock_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebaseServices {
  final FirebaseFirestore firesore = FirebaseFirestore.instance;

//*:add new user to firebase
  Future<String> addNewUser(String name, String phone,
      {String amountPaid = '0',
      String amountReceived = '0',
      String amountWillGet = '0'}) async {
    String response = '';
    try {
      String clientId = const Uuid().v1();
      ClientModel client = ClientModel(
        cid: clientId,
        name: name,
        phoneNumber: phone,
        amountPaid: amountPaid,
        amountReceived: amountReceived,
        amountWillGet: amountWillGet,
      );
      firesore.collection('clients').doc(clientId).set(client.convertToJson());
      response = 'Client added Successfully';
    } catch (err) {
      print(err.toString());
    }
    print(response);
    return response;
  }

//*: remove user from firebase
  Future<String> removeClient(String cId) async {
    String response = '';
    try {
      firesore.collection('clients').doc(cId).delete();
      response = 'Client removed';
    } catch (err) {
      print(err.toString());
    }
    print(response);
    return response;
  }

//*: add stock to firebase
  Future<String> addNewStock(String stockName, String stockCount) async {
    String response = '';
    try {
      String stockId = const Uuid().v1();
      StockModel stock = StockModel(
          sId: stockId, stockName: stockName, stockCount: stockCount);
      firesore.collection('stocks').doc(stockId).set(stock.convertToJson());
      response = 'Stock added Successfully';
    } catch (err) {
      print(err.toString());
    }
    print(response);
    return response;
  }

//*: remove stock from firebase

  Future<String> removeStock(String sId) async {
    String response = '';
    try {
      firesore.collection('stocks').doc(sId).delete();
      response = 'Stock removed';
    } catch (err) {
      print(err.toString());
    }
    print(response);
    return response;
  }
//*: fetch client transaction details

//*: pay to client
  Future<String> payToClient(String cid, String amount, String time) async {
    String response = '';
    try {
      String tid = const Uuid().v1();
      await firesore
          .collection('clients')
          .doc(cid)
          .collection('transactions')
          .doc(tid)
          .set({'dateTime': time, 'paid': amount, 'received': '0'});
      response = 'Payement done Successfully';
    } catch (err) {
      print(err.toString());
    }
    print(response);
    calculatePaidChanges(cid, amount);
    return response;
  }

//*: get payment from client
  Future<String> requestPayment(String cid, String amount, String time) async {
    String response = '';
    try {
      String tid = const Uuid().v1();
      await firesore
          .collection('clients')
          .doc(cid)
          .collection('transactions')
          .doc(tid)
          .set({'dateTime': time, 'paid': '0', 'received': amount});
      response = 'Payement requested Successfully';
    } catch (err) {
      print(err.toString());
    }
    print(response);
    calculateReceivedChanges(cid, amount);
    return response;
  }

  Future<void> calculatePaidChanges(String cid, String amount) async {
    DocumentSnapshot oldData =
        await firesore.collection('clients').doc(cid).get();
    var temp = oldData.data() as Map<String, dynamic>;

    String newPaidEntry =
        (int.parse(amount) + int.parse(temp['amountPaid'])).toString();
    await firesore
        .collection('clients')
        .doc(cid)
        .update({'amountPaid': newPaidEntry});
    await calculateAmountPanding(cid);
    print('Amount to be add: $amount');
    print('newPaidEntry: $newPaidEntry');
    return;
  }

  Future<void> calculateReceivedChanges(String cid, String amount) async {
    DocumentSnapshot oldData =
        await firesore.collection('clients').doc(cid).get();
    var temp = oldData.data() as Map<String, dynamic>;

    String newReceivedEntry =
        (int.parse(amount) + int.parse(temp['amountReceived'])).toString();
    await firesore
        .collection('clients')
        .doc(cid)
        .update({'amountReceived': newReceivedEntry});
    await calculateAmountPanding(cid);
    print('Amount to be received: $amount');
    print('newReceivedEntry: $newReceivedEntry');
    return;
  }

  Future<void> calculateAmountPanding(String cid) async {
    DocumentSnapshot data_ =
        await firesore.collection('clients').doc(cid).get();
    var temp = data_.data() as Map<String, dynamic>;
    String newAmountPandingEntry =
        (int.parse(temp['amountReceived']) - int.parse(temp['amountPaid']))
            .toString();
    await firesore
        .collection('clients')
        .doc(cid)
        .update({'amountWillGet': newAmountPandingEntry});
    print('newAmountPandingEntry: $newAmountPandingEntry');
  }

  Future<List> refreshClientInfo(String cid) async {
    List newDataList = [];
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('clients').doc(cid).get();
    var temp = data.data() as Map<String, dynamic>;
    newDataList.add(temp['amountPaid']);
    newDataList.add(temp['amountReceived']);
    newDataList.add(temp['amountWillGet']);
    print('newDataList: $newDataList');
    return newDataList;
  }
}
