import 'package:voyzo_vendor/Employee/Model/single_employee_profile_response.dart';
import 'package:voyzo_vendor/Employee/Provider/employee_provider.dart';
import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/device_utils.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EmployeeProfileScreen extends StatefulWidget {
  final int id;

  const EmployeeProfileScreen({super.key, required this.id});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late EmployeeProvider employeeProvider;

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    Future.delayed(Duration.zero, () {
      employeeProvider.callSingleEmployee(widget.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    employeeProvider = Provider.of<EmployeeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: employeeProvider.createEmployeeLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: const AppBarBack(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Column(
            children: [
              const HeightBox(20),
              ExtendedImage.network(
                employeeProvider.employeeImage,
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.cover,
                shape: BoxShape.circle,
                height: 100,
                width: 100,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return const SizedBox(
                        height: 0,
                        width: 0,
                      );
                    case LoadState.completed:
                      return ExtendedImage.network(
                        employeeProvider.employeeImage,
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.cover,
                        shape: BoxShape.circle,
                      );
                    case LoadState.failed:
                      return Image.asset(
                        "assets/app/profile.png",
                      );
                  }
                },
              ),
              Text(
                employeeProvider.nameController.text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.bodyText,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              Text(
                employeeProvider.emailController.text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.subText,
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: AppBorderRadius.k10,
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: AppColors.subText,
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  indicator: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppBorderRadius.k10),
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                  tabs: [
                    Tab(
                      text:
                          getTranslated(context, LangConst.profile).toString(),
                    ),
                    Tab(
                      text: getTranslated(context, LangConst.appointment)
                          .toString(),
                    ),
                    Tab(
                      text: getTranslated(context, LangConst.review).toString(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ///Profile
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        top: Amount.screenMargin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///name
                          Text(
                            getTranslated(context, LangConst.nameLabel)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            employeeProvider.nameController.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(10),

                          ///email
                          Text(
                            getTranslated(context, LangConst.emailLabel)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            employeeProvider.emailController.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(10),

                          ///phone number
                          Text(
                            getTranslated(context, LangConst.phoneNumber)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            employeeProvider.phoneNumberController.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(10),

                          ///Experience
                          Text(
                            getTranslated(context, LangConst.experience)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            employeeProvider.experiencedController.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(10),

                          ///Id card number
                          Text(
                            getTranslated(context, LangConst.idCardNumber)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            employeeProvider.idCardNumberController.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(10),

                          ///Start time & End time
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(
                                              context, LangConst.startTime)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.subText),
                                    ),
                                    Text(
                                      employeeProvider.startTime == ""
                                          ? ""
                                          : "${DeviceUtils.formatTime(employeeProvider.startTime)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: AppColors.bodyText,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(context, LangConst.endTime)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.subText),
                                    ),
                                    Text(
                                      employeeProvider.endTime == ""
                                          ? ""
                                          : "${DeviceUtils.formatTime(employeeProvider.endTime)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: AppColors.bodyText,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const HeightBox(10),

                          ///Status
                          Text(
                            getTranslated(context, LangConst.status).toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            employeeProvider.status.name.toSentenceCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(10),
                        ],
                      ),
                    ),

                    ///Appointments
                    employeeProvider.employeeBooking.isEmpty
                        ? Center(
                            child: Text(
                                getTranslated(context, LangConst.noDateFound)
                                    .toString()),
                          )
                        : ListView.separated(
                            itemCount: employeeProvider.employeeBooking.length,
                            separatorBuilder: (context, index) => const Divider(
                                  indent: 0,
                                  endIndent: 0,
                                ),
                            padding:
                                const EdgeInsets.only(top: Amount.screenMargin),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Booking data =
                                  employeeProvider.employeeBooking[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExtendedImage.network(
                                    data.user!.imageUri!,
                                    clipBehavior: Clip.hardEdge,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                    height: 60,
                                    width: 60,
                                    loadStateChanged:
                                        (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return const SizedBox(
                                            height: 0,
                                            width: 0,
                                          );
                                        case LoadState.completed:
                                          return ExtendedImage.network(
                                            data.user!.imageUri!,
                                            width: 60,
                                            height: 60,
                                            clipBehavior: Clip.hardEdge,
                                            fit: BoxFit.cover,
                                            shape: BoxShape.circle,
                                          );
                                        case LoadState.failed:
                                          return Image.asset(
                                            "assets/app/profile.png",
                                          );
                                      }
                                    },
                                  ),
                                  const WidthBox(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data.bookingId!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.bodyText,
                                                  ),
                                            ),
                                            Text(
                                              "${data.currency} ${data.amount}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.complete,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${data.user!.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.bodyText,
                                              ),
                                        ),
                                        Text(
                                          "${data.user!.address ?? "-"}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: AppColors.subText,
                                                fontWeight: FontWeight.w500,
                                              ),
                                          maxLines: 2,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      "${getTranslated(context, LangConst.serviceType.toString())} :",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color:
                                                            AppColors.subText,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          " ${data.serviceType == 0 ? getTranslated(context, LangConst.home).toString() : getTranslated(context, LangConst.shop).toString()}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                            color: AppColors
                                                                .subText,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      "• ${getTranslated(context, LangConst.status).toString()} :",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color:
                                                            AppColors.subText,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          " ${data.status == 0 ? getTranslated(context, LangConst.waitingLabel).toString() : data.status == 1 ? getTranslated(context, LangConst.approvedLabel).toString() : data.status == 2 ? getTranslated(context, LangConst.completeLabel).toString() : data.status == 3 ? getTranslated(context, LangConst.cancelLabel).toString() : getTranslated(context, LangConst.rejectedLabel).toString()}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                            color: AppColors
                                                                .subText,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),

                    ///Reviews
                    employeeProvider.employeeReviews.isEmpty
                        ? Center(
                            child: Text(
                                getTranslated(context, LangConst.noDateFound)
                                    .toString()),
                          )
                        : ListView.separated(
                            itemCount: employeeProvider.employeeReviews.length,
                            separatorBuilder: (context, index) => const Divider(
                                  indent: 0,
                                  endIndent: 0,
                                ),
                            padding:
                                const EdgeInsets.only(top: Amount.screenMargin),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Reviews data =
                                  employeeProvider.employeeReviews[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExtendedImage.network(
                                    data.user!.imageUri!,
                                    clipBehavior: Clip.hardEdge,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                    height: 60,
                                    width: 60,
                                    loadStateChanged:
                                        (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return const SizedBox(
                                            height: 0,
                                            width: 0,
                                          );
                                        case LoadState.completed:
                                          return ExtendedImage.network(
                                            data.user!.imageUri!,
                                            width: 60,
                                            height: 60,
                                            clipBehavior: Clip.hardEdge,
                                            fit: BoxFit.cover,
                                            shape: BoxShape.circle,
                                          );
                                        case LoadState.failed:
                                          return Image.asset(
                                            "assets/app/profile.png",
                                          );
                                      }
                                    },
                                  ),
                                  const WidthBox(12),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.user!.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.bodyText,
                                                ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: AppBorderRadius.k06,
                                              color: const Color(0xFFFFF7E6),
                                              border: Border.all(
                                                color: const Color(0xFFFFD591),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  color:
                                                      AppColors.warningMedium,
                                                  size: 20,
                                                ),
                                                const WidthBox(8),
                                                Text(
                                                  "${data.star}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        color: AppColors
                                                            .warningMedium,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                const WidthBox(4),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "${DeviceUtils.formatDate(data.createdAt!)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              color: AppColors.subText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "${data.cmt != null && data.cmt!.isNotEmpty ? data.cmt : "-"}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: AppColors.subText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        maxLines: 3,
                                      )
                                    ],
                                  ))
                                ],
                              );
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
