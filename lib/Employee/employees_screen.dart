import 'package:voyzo_vendor/Employee/Model/employees_response.dart';
import 'package:voyzo_vendor/Employee/Provider/employee_provider.dart';
import 'package:voyzo_vendor/Employee/create_employee_screen.dart';
import 'package:voyzo_vendor/Employee/employee_profile_screen.dart';
import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late EmployeeProvider employeeProvider;

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      employeeProvider.callgetEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    employeeProvider = Provider.of<EmployeeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: employeeProvider.employeeLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: const AppBarBack(),
          title: Text(getTranslated(context, LangConst.employee).toString()),
        ),
        body: employeeProvider.employees.isEmpty &&
                employeeProvider.employeeLoader == false
            ? Center(
                child: Text(
                  getTranslated(context, LangConst.noDateFound).toString(),
                ),
              )
            : ListView.separated(
                itemCount: employeeProvider.employees.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    bottom: 8,
                  ),
                  child: Divider(
                    endIndent: 0,
                    indent: 0,
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: Amount.screenMargin,
                  bottom: Amount.screenMargin,
                ),
                itemBuilder: (context, index) {
                  EmployeeData data = employeeProvider.employees[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EmployeeProfileScreen(
                                id: data.id!.toInt(),
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Amount.screenMargin,
                        right: Amount.screenMargin,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExtendedImage.network(
                            data.imageUri!,
                            clipBehavior: Clip.hardEdge,
                            fit: BoxFit.cover,
                            shape: BoxShape.circle,
                            height: 60,
                            width: 60,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                case LoadState.completed:
                                  return ExtendedImage.network(
                                    data.imageUri!,
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.hardEdge,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                  );
                                case LoadState.failed:
                                  return Image.asset("assets/app/profile.png");
                              }
                            },
                          ),
                          const WidthBox(12),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///employee name & id
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColors.bodyText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "${getTranslated(context, LangConst.id).toString()} : ${data.idNo ?? "-"}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: AppColors.subText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                              const HeightBox(3),
                              Text(
                                data.email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.subText,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const HeightBox(3),
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                          text: "${data.bookingCount ?? 0}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.bodyText),
                                          children: [
                                            TextSpan(
                                              text:
                                                  " ${getTranslated(context, LangConst.appointments).toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.subText),
                                            )
                                          ]),
                                    ),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                          text: "• ${data.reviewsCount ?? 0}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.bodyText),
                                          children: [
                                            TextSpan(
                                              text:
                                                  " ${getTranslated(context, LangConst.reviews).toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.subText),
                                            )
                                          ]),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateEmployeeScreen(
                                            isEdit: true,
                                            id: data.id!.toInt(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateEmployeeScreen(
                  isEdit: false,
                ),
              ),
            );
          },
          shape:
              const RoundedRectangleBorder(borderRadius: AppBorderRadius.k16),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
