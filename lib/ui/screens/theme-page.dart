import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/bloc/cubit/theme_cubit.dart';
import 'package:gallaryapp/constans/strings.dart';
import 'package:gallaryapp/ui/widgets/app_bar/Custom_App_Bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePage extends StatefulWidget {
  ThemePage({super.key, this.isFirstRun = false});
  final bool isFirstRun;

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
          Title: widget.isFirstRun
              ? context.tr("welcome")
              : context.tr("settings"),
          preferredSize: Size.fromHeight(wid * .05),
          searchavilable: false),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeInitial) {
            theme = state.th;
          }

          if (state is ChangeTheme) theme = state.theme;

          bool value = theme == ThemeMode.dark;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.tr("Dark Mode")),
                  SizedBox(width: 20),
                  Switch(
                      value: value,
                      onChanged: (_) =>
                          BlocProvider.of<ThemeCubit>(context).changetheme()),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Language").tr(),
                  SizedBox(width: 20),
                  DropdownButton<Locale>(
                    value: context.locale,
                    items: [
                      DropdownMenuItem<Locale>(
                          value: Locale("en"),
                          child: Text(context.tr("Language_en"))),
                      DropdownMenuItem<Locale>(
                          value: Locale("ar"),
                          child: Text(context.tr("Language_ar"))),
                    ],
                    onChanged: (value) => context.setLocale(value!),
                  )
                ],
              ),
              widget.isFirstRun
                  ? ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool(firstTime_pref, false);
                        BlocProvider.of<ThemeCubit>(context).FiristRun(false);
                      },
                      child: Text(context.tr("next")))
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
