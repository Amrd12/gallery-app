import 'package:flutter/material.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/constans/strings.dart';

enum NavigationItem {
  home(
    0,
    homeRoute,
    Icons.home_outlined,
    Icons.home,
    MyColors.myGrey,
    MyColors.myYellow,
  ),
  explore(
    1,
    exploreRoute,
    Icons.explore_outlined,
    Icons.explore,
    MyColors.myGrey,
    MyColors.myYellow,
  ),
  settings(
    2,
    layoutRoute,
    Icons.settings_outlined,
    Icons.settings,
    MyColors.myGrey,
    MyColors.myYellow,
  );

  const NavigationItem(
    this.id,
    this.routeName,
    this.icon,
    this.selectedIcon,
    this.bgColor,
    this.fColor,
  );

  final int id;
  final String routeName;
  final IconData icon;
  final IconData selectedIcon;
  final Color bgColor;
  final Color fColor;

  BottomNavigationBarItem get bottomNavigationBarItem {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(selectedIcon),
      label: routeName.replaceFirst("/", "").toUpperCase(),
      backgroundColor: bgColor,
    );
  }
}
