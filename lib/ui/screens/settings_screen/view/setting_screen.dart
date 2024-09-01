import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallaryapp/constans/colors.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/backup/bakeup.dart';
import 'package:gallaryapp/services/shared_pref/shared_pref.dart';
import '../cubit/theme_cubit.dart';
import '../../../main_widgets/app_bar/Custom_App_Bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ThemeMode theme = _sharedPref.isDark ? ThemeMode.dark : ThemeMode.light;
  final SharedPref _sharedPref = locator.get<SharedPref>();
  final Backup _backup = locator.get<Backup>();
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
          title: _sharedPref.isFirstRun
              ? context.tr("welcome")
              : context.tr("settings"),
          preferredSize: Size.fromHeight(wid * .05),
          searchavilable: false),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ChangeTheme) theme = state.theme;

          bool value = theme == ThemeMode.dark;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.tr("Dark Mode")),
                    const SizedBox(width: 20),
                    Switch(
                        value: value,
                        onChanged: (_) =>
                            BlocProvider.of<ThemeCubit>(context).changetheme()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Language").tr(),
                    DropdownButton<Locale>(
                      value: context.locale,
                      items: [
                        DropdownMenuItem<Locale>(
                            value: const Locale("en"),
                            child: Text(context.tr("Language_en"))),
                        DropdownMenuItem<Locale>(
                            value: const Locale("ar"),
                            child: Text(context.tr("Language_ar"))),
                      ],
                      onChanged: (value) => context.setLocale(value!),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () => _backup.restore(
                        onCancel: () => _showSnackBar("restore Canceled"),
                        onCompelete: () => _showSnackBar("restore Compelete")),
                    child: Text("restore".tr())),
                if (!_sharedPref.isFirstRun)
                  ElevatedButton(
                      onPressed: () => _backup.saveFile(
                          onCancel: () => _showSnackBar("Save Canceled"),
                          onCompelete: () => _showSnackBar("Save Compelete")),
                      child: Text("save".tr())),
                if (_sharedPref.isFirstRun)
                  ElevatedButton(
                      onPressed: () =>
                          BlocProvider.of<ThemeCubit>(context).fristRun(),
                      child: Text(context.tr("next")))
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: MyColors.myYellow.withOpacity(.8),
    ));
  }
}
