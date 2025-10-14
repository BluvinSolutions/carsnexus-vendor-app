import 'package:carsnexus_owner/Authentication/login_screen.dart';
import 'package:carsnexus_owner/Employee/employees_screen.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/shop_screen.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Package/package_screen.dart';
import 'package:carsnexus_owner/Profile/notification_screen.dart';
import 'package:carsnexus_owner/Profile/setting_screen.dart';
import 'package:carsnexus_owner/Service%20Request/service_request_screen.dart';
import 'package:carsnexus_owner/Services/service_screen.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Utils/preferences_names.dart';
import 'package:carsnexus_owner/Utils/shared_preferences.dart';
import 'package:carsnexus_owner/Widgets/app_bar_back_icon.dart';
import 'package:carsnexus_owner/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .8,
      child: ListView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            child: Stack(
              children: [
                const Align(alignment: Alignment.topLeft, child: AppBarBack()),
                Positioned(
                  left: 0,
                  right: 0,
                  top: Amount.screenMargin,
                  child: Column(
                    children: [
                      ExtendedImage.network(
                        SharedPreferenceHelper.getString(
                            PreferencesNames.imageUrl),
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.cover,
                        shape: BoxShape.circle,
                        height: 70,
                        width: 70,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            case LoadState.completed:
                              return ExtendedImage.network(
                                SharedPreferenceHelper.getString(
                                    PreferencesNames.imageUrl),
                                width: 70,
                                height: 70,
                                clipBehavior: Clip.hardEdge,
                                fit: BoxFit.cover,
                                shape: BoxShape.circle,
                              );
                            case LoadState.failed:
                              return Image.asset("assets/app/profile.png");
                          }
                        },
                      ),
                      Text(
                        SharedPreferenceHelper.getString(
                            PreferencesNames.userName),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: AppColors.bodyText,
                                fontWeight: FontWeight.w500,
                                fontSize: 24),
                      ),
                      Text(
                        SharedPreferenceHelper.getString(
                            PreferencesNames.email),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.subText),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const HeightBox(
            Amount.screenMargin,
          ),

          ///shops
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShopScreen(),
                ),
              );
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: const Icon(
              CupertinoIcons.briefcase_fill,
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
              getTranslated(context, LangConst.shops).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///Services
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ServicesScreen(),
                ),
              );
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: const Icon(
              CupertinoIcons.rectangle_grid_2x2_fill,
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
              getTranslated(context, LangConst.services).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///Packages
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PackageScreen()));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: SvgPicture.asset("assets/app/package.svg"),
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
              getTranslated(context, LangConst.packages).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///Employee
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EmployeesScreen()));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: const Icon(
              Icons.people,
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
              getTranslated(context, LangConst.employee).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///Waiting Appointment
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ServiceRequestScreen(),
                ),
              );
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: const Icon(
              Icons.verified,
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
              getTranslated(context, LangConst.waitingAppointment).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///notification
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen()));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: const Icon(
              Icons.notifications,
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
              getTranslated(context, LangConst.notification).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///settings
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingScreen()));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.k08,
                side: BorderSide(color: AppColors.stroke)),
            leading: const Icon(
              Icons.settings,
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
              getTranslated(context, LangConst.settings).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
          ),
          const HeightBox(Amount.screenMargin),

          ///logout
          ListTile(
            onTap: () {
              showSignOut(context);
            },
            selectedTileColor: Colors.red.withAlpha(50),
            selected: true,
            shape: const RoundedRectangleBorder(
              borderRadius: AppBorderRadius.k08,
            ),
            leading: SvgPicture.asset(
              "assets/app/logout.svg",
            ),
            contentPadding: const EdgeInsets.only(
                left: Amount.screenMargin,
                right: Amount.screenMargin,
                top: 5,
                bottom: 5),
            visualDensity: const VisualDensity(vertical: -4, horizontal: 4),
            minLeadingWidth: 0,
            title: Text(
              getTranslated(context, LangConst.logout).toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.red),
            ),
          ),
          const HeightBox(Amount.screenMargin),
        ],
      ),
    );
  }

  showSignOut(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.white,
            backgroundColor: AppColors.white,
            actionsPadding:
                const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            title: Text(
              getTranslated(context, LangConst.logout).toString(),
            ),
            content: Text(
              getTranslated(context, LangConst.areYouSureToLogoutThisAccount)
                  .toString(),
              maxLines: 3,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.stroke,
                ),
                child: Text(
                  getTranslated(context, LangConst.cancelLabel).toString(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  SharedPreferenceHelper.remove(PreferencesNames.phoneNo);
                  SharedPreferenceHelper.remove(PreferencesNames.userName);
                  SharedPreferenceHelper.remove(PreferencesNames.isLogin);
                  SharedPreferenceHelper.remove(PreferencesNames.imageUrl);
                  SharedPreferenceHelper.remove(PreferencesNames.authToken);
                  SharedPreferenceHelper.remove(PreferencesNames.email);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4D4F),
                ),
                child: Text(
                  getTranslated(context, LangConst.logout).toString(),
                ),
              ),
            ],
          );
        });
  }
}
