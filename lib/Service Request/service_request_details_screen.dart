import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Service%20Request/Model/single_request_response.dart';
import 'package:carsnexus_owner/Service%20Request/Provider/service_request_provider.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/device_utils.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Widgets/app_bar_back_icon.dart';
import 'package:carsnexus_owner/Widgets/constant_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ServiceRequestDetailsScreen extends StatefulWidget {
  final int id;
  final int index;

  const ServiceRequestDetailsScreen(
      {super.key, required this.id, required this.index});

  @override
  State<ServiceRequestDetailsScreen> createState() =>
      _ServiceRequestDetailsScreenState();
}

class _ServiceRequestDetailsScreenState
    extends State<ServiceRequestDetailsScreen> {
  late ServiceRequestProvider serviceRequestProvider;

  @override
  void initState() {
    super.initState();
    serviceRequestProvider =
        Provider.of<ServiceRequestProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      if (kDebugMode) {
        print("Booking Id ${widget.id}");
      }
      serviceRequestProvider.callSingleRequest(widget.id);
    });
  }

  SingleRequestData? singleRequest;

  @override
  Widget build(BuildContext context) {
    serviceRequestProvider = Provider.of<ServiceRequestProvider>(context);
    if (serviceRequestProvider.singleRequestData != null) {
      singleRequest = serviceRequestProvider.singleRequestData;
    }

    return ModalProgressHUD(
      inAsyncCall: serviceRequestProvider.singleLoader,
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
            getTranslated(context, LangConst.bookingDetails).toString(),
          ),
        ),
        body: singleRequest == null
            ? const SizedBox()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(Amount.screenMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    singleRequest!.status == 0
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.multiply_circle_fill,
                                    size: 20,
                                    color: AppColors.cancel,
                                  ),
                                  label: Text(
                                    getTranslated(context, LangConst.reject)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.cancel,
                                        ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(30),
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    backgroundColor: AppColors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: AppBorderRadius.k08,
                                      side: BorderSide(color: AppColors.stroke),
                                    ),
                                  ),
                                ),
                              ),
                              const WidthBox(20),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: AppColors.white,
                                  ),
                                  label: Text(
                                    getTranslated(context, LangConst.accept)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.white,
                                        ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(30),
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    backgroundColor: AppColors.complete,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: AppBorderRadius.k08,
                                      side: BorderSide(color: AppColors.stroke),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    singleRequest!.status == 0
                        ? const HeightBox(5)
                        : const SizedBox(),

                    ///vehicle details
                    Text(
                      getTranslated(context, LangConst.vehicleType).toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const HeightBox(8),
                    Container(
                      padding: const EdgeInsets.all(Amount.screenMargin),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: AppBorderRadius.k16,
                          border: Border.all(color: AppColors.stroke)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, LangConst.shopName)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            "${singleRequest == null ? "" : singleRequest!.shop!.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.carModel)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    "${singleRequest == null ? "" : singleRequest!.model == null ? "-" : singleRequest!.model!.model!.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.regNumber)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    singleRequest == null
                                        ? ""
                                        : singleRequest!.model != null
                                            ? singleRequest!.model!.regNumber!
                                            : "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.color)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    singleRequest == null
                                        ? ""
                                        : singleRequest!.model != null
                                            ? singleRequest!.model!.color!
                                            : "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const HeightBox(8),

                    ///booking details
                    Text(
                      getTranslated(context, LangConst.bookingDetails)
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const HeightBox(8),
                    Container(
                      padding: const EdgeInsets.all(Amount.screenMargin),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: AppBorderRadius.k16,
                          border: Border.all(color: AppColors.stroke)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, LangConst.orderId)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            "${singleRequest!.bookingId}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          ),
                          const HeightBox(5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.date)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    DeviceUtils.bookingDate(
                                        singleRequest!.startTime!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.time)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    "${DeviceUtils.twentyFourHourFormatWithDate(singleRequest!.startTime!)} to ${DeviceUtils.twentyFourHourFormatWithDate(singleRequest!.endTime!)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ))
                            ],
                          ),
                          const HeightBox(5),
                          Text(
                            getTranslated(context, LangConst.address)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.subText),
                          ),
                          Text(
                            "${singleRequest!.address}",
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const HeightBox(8),

                    ///service Details
                    Text(
                      getTranslated(context, LangConst.serviceDetails)
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const HeightBox(8),
                    Container(
                      padding: const EdgeInsets.all(Amount.screenMargin),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: AppBorderRadius.k16,
                          border: Border.all(color: AppColors.stroke)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(
                                              context, LangConst.servicePlace)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.subText),
                                    ),
                                    Text(
                                      "${getTranslated(context, LangConst.at).toString()} ${singleRequest!.serviceType == 0 ? getTranslated(context, LangConst.home).toString() : getTranslated(context, LangConst.shop).toString()}",
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.employee)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    singleRequest!.employee != null
                                        ? "${singleRequest!.employee!.name}"
                                        : "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          const HeightBox(5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(
                                            context, LangConst.serviceName)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: singleRequest == null
                                        ? 0
                                        : singleRequest!.serviceData!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      ServiceData data =
                                          singleRequest!.serviceData![index];
                                      return Text(
                                        "• ${data.name!}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: AppColors.bodyText,
                                                fontWeight: FontWeight.w500),
                                      );
                                    },
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    getTranslated(context, LangConst.amount)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.subText),
                                  ),
                                  Text(
                                    "${singleRequest!.currency} ${singleRequest!.amount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const HeightBox(8),

                    singleRequest!.status == 1
                        ? const HeightBox(22)
                        : const SizedBox(),

                    ///complete button
                    singleRequest!.status == 1
                        ? ElevatedButton(
                            //TODO: pending
                            onPressed: null,
                            style: AppButtonStyle.filledLarge.copyWith(
                              minimumSize: MaterialStatePropertyAll(
                                Size(MediaQuery.of(context).size.width, 45),
                              ),
                            ),
                            child: Text(
                              getTranslated(context, LangConst.completeLabel)
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
      ),
    );
  }
}
