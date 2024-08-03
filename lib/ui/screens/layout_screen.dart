import 'package:flutter/material.dart';
import 'package:gallaryapp/constans/strings.dart';
import 'package:gallaryapp/ui/screens/Explore.dart';
import 'package:gallaryapp/ui/screens/Home.dart';
import 'package:gallaryapp/ui/screens/theme-page.dart';

import '../../constans/colors.dart';
import '../Navigation_Item.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;
  List<Widget> screen = const [HomeScreen(), Explore(), ThemePage()];
  void _onDestinationSelected(int selectedIndex) {
    index = selectedIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: screen),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColors.myYellow,
          unselectedItemColor: MyColors.myWhite,
          backgroundColor: MyColors.myGrey,
          currentIndex: index,
          onTap: _onDestinationSelected,
          items: NavigationItems().bottomItems),
    );
  }
}
