import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/theme_cubit.dart';
import 'package:gallaryapp/ui/widgets/app_bar/Custom_App_Bar.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeMode theme = ThemeMode.light;

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
              if (state is ChangeTheme) theme = state.theme;

              IconData icon =
                  theme == ThemeMode.light ? Icons.light_mode : Icons.dark_mode;
              return    IconButton(
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
