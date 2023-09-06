import 'package:apnibook/widgets/homePageMenu_widget.dart';
import 'package:apnibook/widgets/listTileForExpenses_widget.dart';
import 'package:flutter/material.dart';

List<Widget> homePageMenus = [
  HomePageMenu_Widget(imagePath: 'assets/images/cash_book.png', text: 'book'),
  HomePageMenu_Widget(imagePath: 'assets/images/cash_book.png', text: 'book'),
  HomePageMenu_Widget(imagePath: 'assets/images/cash_book.png', text: 'book'),
  HomePageMenu_Widget(imagePath: 'assets/images/cash_book.png', text: 'book'),
];

List<Widget> transactionList = [
  ListTileForExpenses_widget(
    name: 'abc',
    phoneNumber: '500',
    imgpath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/330px-User_icon_2.svg.png',
  ),
  ListTileForExpenses_widget(
    name: 'efg',
    phoneNumber: '4620',
    imgpath:
        'https://w7.pngwing.com/pngs/247/564/png-transparent-computer-icons-user-profile-user-avatar-blue-heroes-electric-blue-thumbnail.png',
  ),
  ListTileForExpenses_widget(
    name: 'xyz',
    phoneNumber: '1500',
    imgpath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/330px-User_icon_2.svg.png',
  ),
  ListTileForExpenses_widget(
    name: 'abc',
    phoneNumber: '9653',
  ),
  ListTileForExpenses_widget(
    name: 'pqr',
    phoneNumber: '7500',
    imgpath:
        'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper-thumbnail.png',
  ),
];
