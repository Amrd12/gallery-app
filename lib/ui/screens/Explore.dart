import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:gallaryapp/bloc/cubit/photo_Api_cubit.dart';
import 'package:gallaryapp/ui/widgets/ofline_widget.dart';
import 'package:gallaryapp/ui/widgets/Custom_App_Bar.dart';
import 'package:gallaryapp/ui/widgets/Custom_Bloc_Api.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.height;
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        return BlocProvider(
          create: (context) => PhotoApiCubit(),
          child: Scaffold(
            appBar: CustomAppBar(
              Title: "Explore",
              preferredSize: Size.fromHeight(wid * .05),
              onlineSearch: true,
              searchavilable: connected,
            ),
            body: connected ? const CustomBlocApi() : const OfflineWidget(),
          ),
        );
      },
      child: const OfflineWidget(),
    );
  }
}
