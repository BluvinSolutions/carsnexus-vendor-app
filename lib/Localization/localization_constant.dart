import 'package:carsnexus_owner/Localization/language_localization.dart';
import 'package:carsnexus_owner/Utils/preferences_names.dart';
import 'package:carsnexus_owner/Utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String? getTranslated(BuildContext context, String key) {
  return LanguageLocalization.of(context)!.getTranslateValue(key);
}

const String english = "en";
const String arabic = "ar";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferenceHelper.setString(
      PreferencesNames.currentLanguageCode, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale temp;
  switch (languageCode) {
    case english:
      temp = Locale(languageCode, 'US');
      break;
    case arabic:
      temp = Locale(languageCode, 'AE');
      break;
    default:
      temp = const Locale(english, 'US');
  }
  return temp;
}

Future<Locale> getLocale() async {
  String? languageCode =
      SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode);
  return _locale(languageCode);
}
