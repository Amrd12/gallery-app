import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/Storage/Storage.dart';
import 'package:gallaryapp/bloc/cubit/search_api_cubit.dart';
import 'package:gallaryapp/bloc/cubit/search_storage_cubit.dart';
import 'package:gallaryapp/bloc/cubit/theme_cubit.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/ui/custom_theme.dart';
import 'package:gallaryapp/ui/screens/layout_screen.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'constans/strings.dart';
import 'data/models/Photo_Model.dart';
import 'data/models/Search_Model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await const Storage().makeBaseDirectory();
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(SearchModelAdapter());
  await Hive.openBox<PhotoModel>(hivebox);
  await Hive.openBox<SearchModel>(searchBox);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final CustomTheme theme = CustomTheme();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchStorageCubit()),
        BlocProvider(create: (context) => SearchApiCubit()),
        BlocProvider(
            create: (context) =>
                ThemeCubit()..changetheme(th: ThemeMode.light)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          state as ChangeTheme;
          print("MAIN");
          return MaterialApp(
              themeMode: state.theme,
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
