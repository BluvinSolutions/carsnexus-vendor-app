import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Service%20Request/Model/service_request_response.dart';
import 'package:carsnexus_owner/Service%20Request/Provider/service_request_provider.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Widgets/app_bar_back_icon.dart';
import 'package:carsnexus_owner/Widgets/service_request_listtile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({super.key});

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ServiceRequestProvider serviceRequestProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    serviceRequestProvider =
        Provider.of<ServiceRequestProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      serviceRequestProvider.callBookingRequest();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    serviceRequestProvider = Provider.of<ServiceRequestProvider>(context);
    return DefaultTabController(
        length: 4,
        child: ModalProgressHUD(
          inAsyncCall: serviceRequestProvider.bookingLoader,
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
                  getTranslated(context, LangConst.serviceRequests).toString()),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: SizedBox(
                  height: 40,
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    indicatorPadding: EdgeInsets.zero,
                    tabs: [
                      Tab(
                        text: getTranslated(context, LangConst.waitingLabel)
                            .toString(),
                      ),
                      Tab(
                        text: getTranslated(context, LangConst.approvedLabel)
                            .toString(),
                      ),
                      Tab(
                        text: getTranslated(context, LangConst.completeLabel)
                            .toString(),
                      ),
                      Tab(
                        text: getTranslated(context, LangConst.cancelLabel)
                            .toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                ///waiting
                serviceRequestProvider.waitingBooking.isEmpty &&
                        serviceRequestProvider.bookingLoader == false
                    ? Center(
                        child: Text(
                          getTranslated(context, LangConst.noDateFound)
                              .toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.separated(
                        itemCount: serviceRequestProvider.waitingBooking.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(Amount.screenMargin),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            indent: 0,
                            endIndent: 0,
                            color: AppColors.stroke,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          ServiceRequestData data =
                              serviceRequestProvider.waitingBooking[index];
                          if (kDebugMode) {
                            print(
                                "Waiting Booking Count : ${serviceRequestProvider.waitingBooking.length}");
                          }
                          return ServiceRequestListTile(
                            data: data,
                            index: index,
                          );
                        },
                      ),

                ///approved
                serviceRequestProvider.approvedBooking.isEmpty &&
                        serviceRequestProvider.bookingLoader == false
                    ? Center(
                        child: Text(
                          getTranslated(context, LangConst.noDateFound)
                              .toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.separated(
                        itemCount:
                            serviceRequestProvider.approvedBooking.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(Amount.screenMargin),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            indent: 0,
                            endIndent: 0,
                            color: AppColors.stroke,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          ServiceRequestData data =
                              serviceRequestProvider.approvedBooking[index];
                          if (kDebugMode) {
                            print(
                                "Approved Booking Count : ${serviceRequestProvider.approvedBooking.length}");
                          }
                          return ServiceRequestListTile(
                            data: data,
                            index: index,
                          );
                        },
                      ),

                ///complete
                serviceRequestProvider.completeBooking.isEmpty &&
                        serviceRequestProvider.bookingLoader == false
                    ? Center(
                        child: Text(
                          getTranslated(context, LangConst.noDateFound)
                              .toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.separated(
                        itemCount:
                            serviceRequestProvider.completeBooking.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(Amount.screenMargin),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            indent: 0,
                            endIndent: 0,
                            color: AppColors.stroke,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          ServiceRequestData data =
                              serviceRequestProvider.completeBooking[index];
                          if (kDebugMode) {
                            print(
                                "Complete Booking Count : ${serviceRequestProvider.completeBooking.length}");
                          }
                          return ServiceRequestListTile(
                            data: data,
                            index: index,
                          );
                        },
                      ),

                ///cancel & Rejected
                serviceRequestProvider.cancelBooking.isEmpty &&
                        serviceRequestProvider.bookingLoader == false
                    ? Center(
                        child: Text(
                          getTranslated(context, LangConst.noDateFound)
                              .toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.separated(
                        itemCount: serviceRequestProvider.cancelBooking.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(Amount.screenMargin),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            indent: 0,
                            endIndent: 0,
                            color: AppColors.stroke,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          ServiceRequestData data =
                              serviceRequestProvider.cancelBooking[index];
                          if (kDebugMode) {
                            print(
                                "Cancel Booking Count : ${serviceRequestProvider.cancelBooking.length}");
                          }
                          return ServiceRequestListTile(
                            data: data,
                            index: index,
                          );
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
