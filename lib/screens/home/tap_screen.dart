import 'package:flutter/material.dart';
import 'package:genius_shop/screens/cart_screen/cart_screen.dart';

import '../../widgets/custom_nav_bar.dart';
import '../account_screen/account_screens.dart';
import '../favourite_screen/fav_screen.dart';
import 'home.dart';


class TabScreen extends StatefulWidget {


  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int curTab = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, Widget>> pages = [
      {
        'widget': const Home(),
      },
      {
        'widget': const FavouriteScreen(),
      },
      {
        'widget': const CartScreen(),
      },
      {
        'widget': const AccountScreen(),
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: pages[curTab]['widget']!,
      ),
      bottomNavigationBar: CustomNavBar((index) {
        setState(() {
          curTab = index;
        });
      }, curTab),
    );
  }
}