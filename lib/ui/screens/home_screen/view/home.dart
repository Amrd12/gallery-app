import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../main_widgets/app_bar/Custom_App_Bar.dart';
import '../widgets/Custom_Bloc_Storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr("home"),
        preferredSize: Size.fromHeight(wid * .05),
      ),
      body: const CustomBlocStorage(),
    );
  }
}
