import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gallaryapp/ui/screens/Explore.dart';
import 'package:gallaryapp/ui/screens/Home.dart';
import 'package:gallaryapp/ui/screens/theme-page.dart';

import '../../constans/colors.dart';
import '../Navigation_Item.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({super.key});
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;
  void _onDestinationSelected(int selectedIndex) {
    index = selectedIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: index, children: [HomeScreen(), Explore(), ThemePage()]),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColors.myYellow,
          unselectedItemColor: MyColors.myWhite,
          backgroundColor: MyColors.myGrey,
          currentIndex: index,
          onTap: _onDestinationSelected,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: context.tr("home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: context.tr("explore")),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: context.tr("settings")),
          ]),
    );
  }
}
