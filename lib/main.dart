import "package:hive_flutter/hive_flutter.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallaryapp/Storage/Storage.dart';
import 'package:gallaryapp/bloc/cubit/search_api_cubit.dart';
import 'package:gallaryapp/bloc/cubit/search_storage_cubit.dart';
import 'package:gallaryapp/bloc/cubit/theme_cubit.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/ui/screens/layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constans/strings.dart';
import 'data/models/Photo_Model.dart';
import 'data/models/Search_Model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //shared pref

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setBool(isdark_Pref, true);

  bool? isdark = prefs.getBool(isdark_Pref);
  print(isdark);
  if (isdark == null) {
    await prefs.setBool(isdark_Pref, false);
    isdark = false;
  }
  //hive
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(SearchModelAdapter());
  await Hive.openBox<PhotoModel>(hivebox);
  await Hive.openBox<SearchModel>(searchBox);
  //storage
  await const Storage().makeBaseDirectory();

  runApp(MainApp(isdark: isdark as bool));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.isdark});
  final bool isdark;
  ThemeMode? theme;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchStorageCubit()),
        BlocProvider(create: (context) => SearchApiCubit()),
        BlocProvider(create: (context) => ThemeCubit(isdark)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ChangeTheme) theme = state.theme;
          return MaterialApp(
              themeMode: theme ?? ThemeMode.light,
              theme: ThemeData(scaffoldBackgroundColor: MyColors.myWhite),
              darkTheme: ThemeData(scaffoldBackgroundColor: MyColors.myGrey),
              title: "Gallary App",
              debugShowCheckedModeBanner: false,
              home: const Scaffold(body: LayoutScreen()));
        },
      ),
    );
  }
}
