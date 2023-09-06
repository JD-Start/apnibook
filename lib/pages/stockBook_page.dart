import 'package:apnibook/pages/addStock_page.dart';
import 'package:apnibook/pages/home_page.dart';
import 'package:apnibook/services/firebaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets/showStocks_widget.dart';

class StockBook_Page extends StatefulWidget {
  const StockBook_Page({super.key});
  @override
  State<StockBook_Page> createState() => _StockBook_PageState();
}

class _StockBook_PageState extends State<StockBook_Page> {
  @override
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AddStock_Page(),
                ));
          },
          child: const Icon(Icons.add, size: 32)),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Home_Page(),
                ));
          },
          icon: const Icon(Icons.arrow_back, size: 24),
        ),
        centerTitle: true,
        title: const Text(
          'Stock Book',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('stocks').snapshots(),
              builder: (context, snapshot) {
                // itemCount = FirebaseFirestore.instance
                //     .collection('stocks')
                //     .snapshots()
                //     .length;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: 5,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onLongPress: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Stock deletion',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    content: const Text(
                                      'Are you sure want to delete this Stock?',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: InkWell(
                                          onTap: () {
                                            print(snapshot.data!.docs[index]
                                                .data()['sId']);
                                            FirebaseServices().removeStock(
                                                snapshot.data!.docs[index]
                                                    .data()['sId']);
                                            DisplaySnackBar(
                                                context,
                                                'Stock deleted',
                                                Colors.red.shade300);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              fontSize: 14,
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
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ShowStock_widget(
                              text: snapshot.data!.docs[index]
                                  .data()['stockName'],
                              stockCount: snapshot.data!.docs[index]
                                  .data()['stockCount'],
                            ));
                      },
                    )

                    // ListView.separated(
                    //   separatorBuilder: (context, index) => const SizedBox(
                    //     height: 5,
                    //   ),
                    //   itemCount: snapshot.data!.docs.length,
                    //   itemBuilder: (context, index) {
                    //     return

                    //     // --------
                    // InkWell(
                    //   onLongPress: () {
                    //     FirebaseServices().removeClient(
                    //         snapshot.data!.docs[index].data()['cid']);
                    //   },
                    //   child: ShowStock_widget(
                    //     text: snapshot.data!.docs[index].data()['stockName'],
                    //     stockCount:
                    //         snapshot.data!.docs[index].data()['stockCount'],
                    //   ),

                    //     // --------

                    // ListTileForExpenses_widget(
                    //     name: snapshot.data!.docs[index].data()['name'],
                    //     phoneNumber:
                    //         snapshot.data!.docs[index].data()['phoneNumber']),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
  // ),

  // GridView.count(
  //   crossAxisCount: 2,
  //   children: [
  //     ShowStock_widget(text: 'Laptop', stockCount: '2'),
  //     ShowStock_widget(text: 'Charger', stockCount: '4'),
  //   ],
  // ),
  //       ),
  //     ),
  //   ),
  // )
}
// }
