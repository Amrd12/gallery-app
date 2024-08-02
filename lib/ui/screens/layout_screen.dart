import 'package:flutter/material.dart';
import 'package:gallaryapp/ui/screens/Explore.dart';
import 'package:gallaryapp/ui/screens/Home.dart';

import '../../constans/colors.dart';
import '../Navigation_Item.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;
  List<Widget> screen = const [HomeScreen(), Explore()];
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
          items: NavigationItems().bottomItems,
          currentIndex: index,
          onTap: _onDestinationSelected),
    );
  }
}
