import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/photo_storage_cubit.dart';
import 'package:gallaryapp/ui/widgets/Custom_Bloc_Storage.dart';
import '../widgets/Custom_App_Bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PhotoStorageCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          Title: "Home",
          preferredSize: Size.fromHeight(wid * .05),
        ),
        body: CustomBlocStorage(),
      ),
    );
  }
}
