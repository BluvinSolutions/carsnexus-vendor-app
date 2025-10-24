import 'package:voyzo_vendor/Home%20&%20Shops/Provider/home_provider.dart';
import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Profile/custom_drawer.dart';
import 'package:voyzo_vendor/Service Request/service_request_screen.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Utils/preferences_names.dart';
import 'package:voyzo_vendor/Utils/shared_preferences.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      homeProvider.callHomeApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: homeProvider.homeLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leadingWidth: 65,
          leading: InkWell(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 15,
                top: 2,
                bottom: 2,
              ),
              padding: const EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: 5,
              ),
              child: ExtendedImage.network(
                SharedPreferenceHelper.getString(PreferencesNames.imageUrl),
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.cover,
                shape: BoxShape.circle,
                height: 65,
                width: 65,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return const SpinKitPulsingGrid(
                        color: AppColors.primary,
                        size: 25.0,
                      );
                    case LoadState.completed:
                      return ExtendedImage.network(
                        SharedPreferenceHelper.getString(
                            PreferencesNames.imageUrl),
                        width: 65,
                        height: 65,
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.cover,
                        shape: BoxShape.circle,
                      );
                    case LoadState.failed:
                      return Image.asset("assets/app/profile.png");
                  }
                },
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SharedPreferenceHelper.getString(PreferencesNames.userName),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: AppColors.accent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                getTranslated(context, LangConst.welcomeToApp).toString(),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          centerTitle: false,
        ),
        body: Center(
          child: Image.asset(
            "assets/Dummy/map.png",
            height: MediaQuery.of(context).size.height * 08,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: Card(
            margin: EdgeInsets.zero,
            color: AppColors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              side: BorderSide(color: AppColors.stroke),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Amount.screenMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, LangConst.todayWork)
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              "${homeProvider.todayWork} ${getTranslated(context, LangConst.workCompleted).toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.complete,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${homeProvider.currency} ${homeProvider.todayIncome}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const HeightBox(15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k12,
                              border: Border.all(color: AppColors.stroke)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: AppBorderRadius.k08,
                                  color: const Color(0xFFF9F0FF),
                                  border: Border.all(
                                    color: const Color(0xFFD3ADF7),
                                  ),
                                ),
                                child: const Icon(
                                  CupertinoIcons.house_alt_fill,
                                  color: Color(0xFF9254DE),
                                  size: 20,
                                ),
                              ),
                              const HeightBox(3),
                              Text(
                                getTranslated(context, LangConst.serviceAtHome)
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.bodyText,
                                        fontWeight: FontWeight.w600),
                              ),
                              RichText(
                                text: TextSpan(
                                    text:
                                        "${homeProvider.homeWork} ${getTranslated(context, LangConst.works).toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColors.subText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " • ${homeProvider.currency} ${homeProvider.homeIncome}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const WidthBox(15),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k12,
                              border: Border.all(color: AppColors.stroke)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: AppBorderRadius.k08,
                                  color: const Color(0xFFFFF7E6),
                                  border: Border.all(
                                    color: const Color(0xFFFFD591),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.shop_rounded,
                                  color: Color(0xFFFFA940),
                                  size: 20,
                                ),
                              ),
                              const HeightBox(3),
                              Text(
                                getTranslated(context, LangConst.serviceAtShop)
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.bodyText,
                                        fontWeight: FontWeight.w600),
                              ),
                              RichText(
                                text: TextSpan(
                                    text:
                                        "${homeProvider.shopWork} ${getTranslated(context, LangConst.works).toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColors.subText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " • ${homeProvider.currency} ${homeProvider.shopIncome}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const HeightBox(30),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ServiceRequestScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: Amount.screenMargin,
                          right: Amount.screenMargin,
                          bottom: 10,
                          top: 10),
                      decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.k08,
                          border: Border.all(color: AppColors.primary)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(
                                    context, LangConst.viewServiceRequests)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
