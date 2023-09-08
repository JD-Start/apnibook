import 'package:apnibook/pages/business_page.dart';
import 'package:apnibook/pages/clientBook_page.dart';
import 'package:apnibook/pages/expenses_page.dart';
import 'package:apnibook/pages/help_page.dart';
import 'package:apnibook/pages/stockBook_page.dart';
import 'package:apnibook/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  HomePageMenu_Widget_(String imgpath, String name, Function() onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(8),
        height: 135,
        width: 135,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24),
          boxShadow: shadow,
          border: Border.all(color: Colors.green, width: 1.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imgpath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: Center(
            child: Text(
              'Apni Book App',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Apni Book',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Help',
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Help_Page(),
                ));
          },
          child: const Icon(Icons.help_outline_rounded, size: 32),
        ),
        body: SizedBox(
          height: 500,
          width: 500,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomePageMenu_Widget_(
                        'assets/images/client_book.png', 'Client Book', () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const ClientBook_Page(),
                          ));
                    }),
                    HomePageMenu_Widget_(
                        'assets/images/stock_book.png', 'Stock book', () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const StockBook_Page(),
                          ));
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomePageMenu_Widget_(
                        'assets/images/cash_book.png', 'Business Book', () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Business_Page(),
                          ));
                    }),
                    HomePageMenu_Widget_(
                        'assets/images/expense_book.png', 'Expenses Book', () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Expenses_Page(),
                          ));
                    }),
                  ],
                )

                // Container(
                //   margin: const EdgeInsets.all(5),
                //   padding: const EdgeInsets.all(8),
                //   height: 100,
                //   width: 100,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       border: Border.all(color: Colors.green, width: 1.5)),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         'assets/images/cash_book.png',
                //         height: 50,
                //         width: 50,
                //         fit: BoxFit.cover,
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       const Text(
                //         'text',
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        )
        // SizedBox(
        //   height: 500,
        //   width: 500,
        //   child: GridView.count(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 1,
        //     mainAxisSpacing: 1,
        //     children: homePageMenus,
        //   ),
        // ),
        );
  }
}
