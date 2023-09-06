import 'package:flutter/material.dart';

class ListTileForExpenses_widget extends StatefulWidget {
  String phoneNumber;
  String imgpath;
  String name;
  ListTileForExpenses_widget(
      {super.key,
      required this.name,
      required this.phoneNumber,
      this.imgpath =
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/330px-User_icon_2.svg.png'});
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
          side: const BorderSide(width: 2)),
      leading: CircleAvatar(
          maxRadius: 15, backgroundImage: NetworkImage(widget.imgpath)),
      title: Text(
        widget.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.phoneNumber,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
