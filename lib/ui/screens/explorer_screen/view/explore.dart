import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:gallaryapp/ui/main_widgets/app_bar/custom_app_bar.dart';
import '../cubit/photo_Api_cubit.dart';
import '../../../main_widgets/ofline_widget.dart';
import '../widgets/Custom_Bloc_Api.dart';

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
              title: context.tr("explore"),
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
