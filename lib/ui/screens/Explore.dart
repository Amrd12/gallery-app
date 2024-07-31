import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/photo_Api_cubit.dart';
import 'package:gallaryapp/ui/widgets/Custom_App_Bar.dart';
import 'package:gallaryapp/ui/widgets/Custom_Bloc_Api.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PhotoApiCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          Title: "Explore",
          preferredSize: Size.fromHeight(wid * .05),
          onlineSearch: true,
        ),
        body: CustomBlocApi(),
      ),
    );
  }
}
