import 'package:apnibook/pages/addUser_page.dart';
import 'package:apnibook/pages/clientDetails_page.dart';
import 'package:apnibook/pages/home_page.dart';
import 'package:apnibook/services/firebaseServices.dart';
import 'package:apnibook/utils.dart';
import 'package:apnibook/widgets/listTileForExpenses_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientBook_Page extends StatefulWidget {
  const ClientBook_Page({super.key});
  @override
  State<ClientBook_Page> createState() => _ClientBook_PageState();
}

class _ClientBook_PageState extends State<ClientBook_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new Client',
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddUser_Page(),
              ));
        },
        child: const Icon(Icons.add, size: 32),
      ),
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
          'Client Book',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clients').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Client deletion',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          content: const Text(
                            'Are you sure want to delete this Client?',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: InkWell(
                                onTap: () {
                                  print(
                                      snapshot.data!.docs[index].data()['cid']);
                                  FirebaseServices().removeClient(
                                      snapshot.data!.docs[index].data()['cid']);
                                  DisplaySnackBar(context, 'Client deleted',
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

                    // FirebaseServices()
                    //     .removeClient(snapshot.data!.docs[index].data()['cid']);
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ClientDetails_Page(
                                snap: snapshot.data!.docs[index].data()),
                          ));
                      // ClientDetails_Page(
                      //     snap: snapshot.data!.docs[index].data());
                    },
                    child: ListTileForExpenses_widget(
                        name: snapshot.data!.docs[index].data()['name'],
                        phoneNumber:
                            snapshot.data!.docs[index].data()['phoneNumber']),
                  ),
                );
              },
            ),
          );
        },
      ),

      //  Container(
      //   padding: const EdgeInsets.all(20),
      //   child: ListView.separated(
      //     itemBuilder: (context, index) {
      //       return transactionList[index];
      //     },
      //     itemCount: transactionList.length,
      //     separatorBuilder: (context, index) => const SizedBox(
      //       height: 10,
      //     ),
      //   ),
      // ),
    );
  }
}
