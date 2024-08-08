import 'package:gallaryapp/generated/lib/codegen_loader.g.dart';
import 'package:gallaryapp/ui/screens/theme-page.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //shared pref
  await EasyLocalization.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setBool(isdark_Pref, true);

  bool? isdark = prefs.getBool(isdark_Pref);
  print("isdark $isdark");
  if (isdark == null) {
    await prefs.setBool(isdark_Pref, true);
    isdark = false;
  }

  // await prefs.setBool(firstTime_pref, true);

  bool isFirstRun = prefs.getBool(firstTime_pref) ?? true;

  //hive
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(SearchModelAdapter());
  await Hive.openBox<PhotoModel>(hivebox);
  await Hive.openBox<SearchModel>(searchBox);
  //storage
  await const Storage().makeBaseDirectory();

  runApp(MainApp(isdark: isdark, isFirstRun: isFirstRun));
}

class MainApp extends StatefulWidget {
  MainApp({super.key, required this.isdark, required this.isFirstRun});
  final bool isdark, isFirstRun;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late ThemeMode theme;
  late bool first;
  @override
  void initState() {
    theme = widget.isdark ? ThemeMode.dark : ThemeMode.light;
    first = widget.isFirstRun;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchStorageCubit()),
        BlocProvider(create: (context) => SearchApiCubit()),
        BlocProvider(create: (context) => ThemeCubit(theme)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ChangeTheme) {
            theme = state.theme;
          }

          if (state is IsFirstRun) {
            first = state.isFirstRun;
          }

          return EasyLocalization(
              saveLocale: true,
              assetLoader: CodegenLoader(),
              startLocale: Locale("en"),
              supportedLocales: [Locale("en"), Locale("ar")],
              path: "translations",
              child: App(theme: theme, isFirstRun: first));
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  App({super.key, required this.theme, required this.isFirstRun});

  final ThemeMode theme;
  final bool isFirstRun;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        themeMode: theme,
        theme: ThemeData(scaffoldBackgroundColor: MyColors.myWhite),
        darkTheme: ThemeData(scaffoldBackgroundColor: MyColors.myGrey),
        title: "Gallary App",
        debugShowCheckedModeBanner: false,
        home: isFirstRun ? ThemePage(isFirstRun: true) : LayoutScreen());
  }
}
