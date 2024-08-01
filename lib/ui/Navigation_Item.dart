import 'package:flutter/material.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/constans/strings.dart';

class NavigationItem {
  final int id;
  final String routeName;
  final IconData icon;
  final IconData selectedicon;
  final Color bgColor;
  final Color fColor;

  const NavigationItem(this.id, this.routeName, this.icon, this.selectedicon,
      {this.bgColor = MyColors.myGrey, this.fColor = MyColors.myYellow});

  NavigationRailDestination get navigationRailDestination {
    return NavigationRailDestination(
      icon: Icon(
        icon,
        color: fColor,
        size: 40,
      ),
      selectedIcon: Icon(
        selectedicon,
        color: Colors.white,
        size: 40,
      ),
      label: Text(
        routeName.replaceFirst("/", "").toUpperCase(),
      ),
    );
  }

  BottomNavigationBarItem get bottomNavigationBarItem {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      activeIcon: Icon(
        selectedicon,
      ),
      label: routeName.replaceFirst("/", "").toUpperCase(),
      backgroundColor: bgColor,
    );
  }
}

class NavigationItems {
  bool expanded = false;

  static const List<NavigationItem> _items = [
    NavigationItem(0, homeRoute, Icons.home_outlined, Icons.home),
    NavigationItem(1, exploreRoute, Icons.explore_outlined, Icons.explore)
  ];

  NavigationRailDestination _getNavigationRailDestination(int index) {
    return _items[index].navigationRailDestination;
  }

  BottomNavigationBarItem _getBottomNavigationBarItem(int index) {
    return _items[index].bottomNavigationBarItem;
  }

  List<BottomNavigationBarItem> get bottomItems => List.generate(
        length,
        (index) => _getBottomNavigationBarItem(index),
      );

  List<NavigationRailDestination> get railItems => List.generate(
        length,
        (index) => _getNavigationRailDestination(index),
      );
  int get length => _items.length;
  String itemRouteName(int i) => _items[i].routeName;
}
