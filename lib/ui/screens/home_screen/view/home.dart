import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallaryapp/generated/lib/LocaleKeys.g.dart';
import 'package:gallaryapp/ui/screens/home_screen/cubit/photo_storage_cubit.dart';
import '../../../main_widgets/app_bar/Custom_App_Bar.dart';
import '../widgets/Custom_Bloc_Storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // log(LocaleKeys.home.tr());
    final wid = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PhotoStorageCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.tr("home"),
          preferredSize: Size.fromHeight(wid * .05),
        ),
        body: const CustomBlocStorage(),
      ),
    );
  }
}
