import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/primisions/request_permission.dart';
import 'package:gallaryapp/services/shared_pref/shared_pref.dart';
import 'package:gallaryapp/ui/screens/explorer_screen/cubit/search_api_cubit.dart';
import 'package:gallaryapp/ui/screens/home_screen/cubit/photo_storage_cubit.dart';
import 'package:gallaryapp/ui/screens/home_screen/cubit/search_storage_cubit.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'services/Storage/Storage.dart';
import 'constans/colors.dart';
import 'constans/strings.dart';
import 'data/models/photo_model.dart';
import 'data/models/search_model.dart';
import 'ui/screens/layout_screen.dart';
import 'ui/screens/settings_screen/cubit/theme_cubit.dart';
import 'ui/screens/settings_screen/view/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //shared pref
  await EasyLocalization.ensureInitialized();
  setup();

  final SharedPref sharedPref = locator.get<SharedPref>();
  sharedPref.setup();

  //hive
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(SearchModelAdapter());
  await Hive.openBox<PhotoModel>(HiveBoxNames.hiveBox);
  await Hive.openBox<SearchModel>(HiveBoxNames.searchBox);
  //storage
  await const Storage().makeBaseDirectory();
  await requestPermission();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final SharedPref _sharedPref = locator.get<SharedPref>();
  late ThemeMode theme;
  late bool first;

  @override
  void initState() {
    theme = _sharedPref.isDark ? ThemeMode.dark : ThemeMode.light;
    first = _sharedPref.isFirstRun;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchStorageCubit()),
        BlocProvider(create: (context) => SearchApiCubit()),
        BlocProvider(create: (context) => ThemeCubit(theme)),
        BlocProvider(
          create: (context) => PhotoStorageCubit(),
        ),
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
              // assetLoader: const CodegenLoader(),
              startLocale: const Locale("en"),
              supportedLocales: const [Locale("en"), Locale("ar")],
              path: "translations",
              child: App(
                theme: theme,
                isFirstRun: first,
              ));
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key, required this.theme, required this.isFirstRun});
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
        home: isFirstRun ? const SettingScreen() : const LayoutScreen());
  }
}
