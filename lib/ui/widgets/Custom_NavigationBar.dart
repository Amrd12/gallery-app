// import 'package:flutter/material.dart';
// import 'package:gallaryapp/constans/colors.dart';
// import 'package:gallaryapp/constans/strings.dart';
// import 'package:gallaryapp/ui/Navigation_Item.dart';
// import 'package:gallaryapp/routes.dart';

// class CustomNavigationbar extends StatefulWidget {
//   const CustomNavigationbar({super.key});

//   @override
//   _CustomNavigationbarState createState() => _CustomNavigationbarState();
// }

// class _CustomNavigationbarState extends State<CustomNavigationbar> {
//   int index = 0;
//   bool expanded = false;
//   void onpressed() {
//     expanded = !expanded;
//     setState(() {});
//   }

//   Widget get expandedIcon => expanded
//       ? IconButton(
//           onPressed: onpressed,
//           icon: const Icon(
//             Icons.menu_open,
//             size: 30,
//             color: MyColors.myWhite,
//           ),
//         )
//       : IconButton(
//           onPressed: onpressed,
//           icon: const Icon(
//             Icons.menu,
//             size: 30,
//             color: MyColors.myWhite,
//           ),
//         );

//   final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

//   void _onDestinationSelected(int selectedIndex) {
//     if (index != selectedIndex) {
//       index = selectedIndex;
//       _navigatorKey.currentState
//           ?.popAndPushNamed(NavigationItems().itemRouteName(selectedIndex));
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     if (width >= 820) {
//       return Row(
//         children: [
//           NavigationRail(
//             selectedIconTheme: const IconThemeData(size: 100),
//             unselectedIconTheme: const IconThemeData(size: 100),
//             groupAlignment: 0.0,
//             extended: expanded,
//             leading: expandedIcon,
//             unselectedLabelTextStyle:
//                 const TextStyle(fontSize: 30, color: MyColors.myYellow),
//             selectedLabelTextStyle:
//                 const TextStyle(fontSize: 30, color: MyColors.myWhite),
//             backgroundColor: MyColors.myGrey,
//             useIndicator: false,
//             destinations: NavigationItems().railItems,
//             selectedIndex: index,
//             onDestinationSelected: _onDestinationSelected,
//           ),
//           Expanded(
//             child: Navigator(
//                 key: _navigatorKey,
//                 initialRoute: homeRoute,
//                 onGenerateRoute: (settings) =>
//                     AppGenerateRouter().generateroute(settings)),
//           )
//         ],
//       );
//     } else {
//       return Column(
//         children: [
//           Expanded(
//             child: Navigator(
//                 key: _navigatorKey,
//                 initialRoute: homeRoute,
//                 onGenerateRoute: (settings) =>
//                     AppGenerateRouter().generateroute(settings)),
//           ),
//           BottomNavigationBar(
//               selectedItemColor: MyColors.myWhite,
//               unselectedItemColor: MyColors.myYellow,
//               backgroundColor: MyColors.myGrey,
//               items: NavigationItems().bottomItems,
//               currentIndex: index,
//               onTap: _onDestinationSelected)
//         ],
//       );
//     }
//   }
// }
