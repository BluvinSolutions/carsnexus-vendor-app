import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Profile/Provider/profile_provider.dart';
import 'package:voyzo_vendor/Profile/edit_profile_screen.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Utils/preferences_names.dart';
import 'package:voyzo_vendor/Utils/shared_preferences.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:voyzo_vendor/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int? value;

  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      profileProvider.callgetProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: profileProvider.settingLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: const AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.settings).toString(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.k08,
                    side: BorderSide(color: AppColors.stroke)),
                leading: const Icon(
                  CupertinoIcons.person_crop_square,
                  size: 22,
                  color: AppColors.primary,
                ),
                contentPadding: const EdgeInsets.only(
                    left: Amount.screenMargin,
                    right: Amount.screenMargin,
                    top: 5,
                    bottom: 5),
                visualDensity: const VisualDensity(vertical: -4, horizontal: 4),
                minLeadingWidth: 0,
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 18,
                  color: AppColors.stroke,
                ),
                title: Text(
                  getTranslated(context, LangConst.editProfile).toString(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.bodyText),
                ),
              ),
              const HeightBox(Amount.screenMargin),
              SwitchListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: AppBorderRadius.k08,
                      side: BorderSide(color: AppColors.stroke)),
                  contentPadding: const EdgeInsets.only(
                      left: Amount.screenMargin, top: 5, bottom: 5),
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: -4),
                  secondary: const Icon(
                    Icons.settings,
                    size: 22,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    getTranslated(context, LangConst.notification).toString(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.bodyText),
                  ),
                  value: profileProvider.isNotification,
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.icon,
                  onChanged: (bool value) {
                    setState(() {
                      profileProvider.isNotification = value;
                    });
                    Map<String, dynamic> body = {"noti": value == true ? 1 : 0};
                    profileProvider.callUpdateProfile(body);
                  }),
              const HeightBox(Amount.screenMargin),
              ListTile(
                onTap: () {
                  showLanguageModelBottomSheet();
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.k08,
                    side: BorderSide(color: AppColors.stroke)),
                leading: const Icon(
                  Icons.translate_outlined,
                  size: 22,
                  color: AppColors.primary,
                ),
                contentPadding: const EdgeInsets.only(
                    left: Amount.screenMargin,
                    right: Amount.screenMargin,
                    top: 5,
                    bottom: 5),
                visualDensity: const VisualDensity(vertical: -4, horizontal: 4),
                minLeadingWidth: 0,
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 18,
                  color: AppColors.stroke,
                ),
                title: Text(
                  getTranslated(context, LangConst.language).toString(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.bodyText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showLanguageModelBottomSheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 125,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(28),
                            topLeft: Radius.circular(28))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Amount.screenMargin,
                            right: Amount.screenMargin,
                          ),
                          child: Text(
                            getTranslated(context, LangConst.language)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListView.builder(
                            itemCount: Language.languageList().length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                left: Amount.screenMargin,
                                right: Amount.screenMargin),
                            itemBuilder: (context, index) {
                              value = 0;
                              value = Language.languageList()[index]
                                          .languageCode ==
                                      SharedPreferenceHelper.getString(
                                          PreferencesNames.currentLanguageCode)
                                  ? index
                                  : null;
                              if (SharedPreferenceHelper.getString(
                                      PreferencesNames.currentLanguageCode) ==
                                  'N/A') {
                                value = 0;
                              }
                              return ListTile(
                                onTap: () async {
                                  Locale local = await setLocale(
                                      Language.languageList()[index]
                                          .languageCode);
                                  setState(() {
                                    MyApp.setLocale(context, local);
                                    SharedPreferenceHelper.setString(
                                        PreferencesNames.currentLanguageCode,
                                        Language.languageList()[index]
                                            .languageCode);
                                    Navigator.of(context).pop();
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                title: Text(
                                  index == 0 ? "English (US)" : "Arabic",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: AppColors.bodyText,
                                          fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  SharedPreferenceHelper.getString(
                                                      PreferencesNames
                                                          .currentLanguageCode) ==
                                                  'N/A' &&
                                              index == 0 ||
                                          SharedPreferenceHelper.getString(
                                                  PreferencesNames
                                                      .currentLanguageCode) ==
                                              Language.languageList()[index]
                                                  .languageCode
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: AppColors.primary,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'English', '🇺🇸', 'en'),
      Language(2, 'Arabic', 'AE', 'ar')
    ];
  }
}
