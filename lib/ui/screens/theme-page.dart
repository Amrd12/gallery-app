import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/theme_cubit.dart';
import 'package:gallaryapp/ui/widgets/Custom_App_Bar.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
          Title: "settings",
          preferredSize: Size.fromHeight(wid * .05),
          searchavilable: false),
      body: Container(
        child: Center(
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              state as ChangeTheme;
              IconData icon = state.theme == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode;
              return IconButton(
                  onPressed: () =>
                      BlocProvider.of<ThemeCubit>(context).changetheme(),
                  icon: Icon(icon));
            },
          ),
        ),
      ),
    );
  }
}
