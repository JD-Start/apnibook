import 'package:apnibook/services/firebaseServices.dart';
import 'package:apnibook/utils.dart';
import 'package:flutter/material.dart';

class ListTileForExpenses_widget extends StatefulWidget {
  String phoneNumber;
  String imgpath;
  String name;
  String cid;
  ListTileForExpenses_widget(
      {super.key,
      required this.name,
      required this.phoneNumber,
      this.imgpath =
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/330px-User_icon_2.svg.png',
      required this.cid});
  @override
  State<ListTileForExpenses_widget> createState() =>
      _ListTileForExpenses_widgetState();
}

class _ListTileForExpenses_widgetState
    extends State<ListTileForExpenses_widget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(3),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 2, color: Colors.green.shade300)),
      leading: CircleAvatar(
          maxRadius: 22, backgroundImage: NetworkImage(widget.imgpath)),
      title: Text(
        widget.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      visualDensity: VisualDensity.compact,
      subtitle: Text(
        widget.phoneNumber,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, size: 24, color: Colors.red.shade300),
        onPressed: () {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text(
                  'Client deletion',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  'Are you sure want to delete this Client?',
                  style: TextStyle(
                    fontSize: 16,
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
                            FirebaseServices().removeClient(widget.cid);
                            DisplaySnackBar(
                                context, 'Client deleted', Colors.red.shade300);
                            Navigator.pop(context);
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
                          onPressed: () {},
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
        },
      ),
    );
  }
}
