import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constans/colors.dart';
import 'explorer_screen/view/explore.dart';
import 'home_screen/view/home.dart';
import 'settings_screen/view/setting_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
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
          index: index,
          children: const [HomeScreen(), Explore(), SettingScreen()]),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColors.myYellow,
          unselectedItemColor: MyColors.myWhite,
          backgroundColor: MyColors.myGrey,
          currentIndex: index,
          onTap: _onDestinationSelected,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: context.tr("home")),
            BottomNavigationBarItem(
                icon: const Icon(Icons.explore_outlined),
                activeIcon: const Icon(Icons.explore),
                label: context.tr("explore")),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                activeIcon: const Icon(Icons.settings),
                label: context.tr("settings")),
          ]),
    );
  }
}
