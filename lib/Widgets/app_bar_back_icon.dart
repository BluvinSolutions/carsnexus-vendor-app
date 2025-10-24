import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/preferences_names.dart';
import 'package:voyzo_vendor/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppBarBack extends StatelessWidget {
  const AppBarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: SharedPreferenceHelper.getString(
                        PreferencesNames.currentLanguageCode) ==
                    "en" ||
                SharedPreferenceHelper.getString(
                        PreferencesNames.currentLanguageCode) ==
                    "N/A"
            ? const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 5)
            : const EdgeInsets.only(left: 5, top: 8, bottom: 8, right: 8),
        padding: SharedPreferenceHelper.getString(
                        PreferencesNames.currentLanguageCode) ==
                    "en" ||
                SharedPreferenceHelper.getString(
                        PreferencesNames.currentLanguageCode) ==
                    "N/A"
            ? const EdgeInsets.only(top: 8, bottom: 8, left: 11, right: 5)
            : const EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 11),
        decoration: BoxDecoration(
            borderRadius: AppBorderRadius.k10,
            border: Border.all(color: AppColors.stroke)),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: AppColors.icon,
        ),
      ),
    );
  }
}
