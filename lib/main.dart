import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/Storage/Storage.dart';
import 'package:gallaryapp/bloc/cubit/search_api_cubit.dart';
import 'package:gallaryapp/bloc/cubit/search_storage_cubit.dart';
import 'package:gallaryapp/ui/widgets/Custom_NavigationBar.dart';
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
  // final box = Hive.box<PhotoModel>(hivebox);
  // await box.deleteAll(box.keys);
  // Directory(await Storage().getBaseDirectory()).deleteSync(recursive: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Gallary App",
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SearchStorageCubit()),
            BlocProvider(create: (context) => SearchApiCubit()),
          ],
          child: const Scaffold(body: CustomNavigationbar()),
        ));
  }
}

        // initialRoute: navigationRoute,
        // // routes: AppRouter,
        // onGenerateRoute: (settings) =>
        //     AppGenerateRouter().generateroute(settings),