import 'package:carsnexus_owner/Employee/Model/employees_response.dart';
import 'package:carsnexus_owner/Employee/Provider/employee_provider.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Service Request/service_request_details_screen.dart';
import 'package:carsnexus_owner/Service%20Request/Model/service_request_response.dart';
import 'package:carsnexus_owner/Service%20Request/Provider/service_request_provider.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/device_utils.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceRequestListTile extends StatefulWidget {
  final ServiceRequestData data;
  final int index;

  const ServiceRequestListTile(
      {super.key, required this.data, required this.index});

  @override
  State<ServiceRequestListTile> createState() => _ServiceRequestListTileState();
}

class _ServiceRequestListTileState extends State<ServiceRequestListTile> {
  late EmployeeProvider employeeProvider;

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    if (widget.data.status == 0) {
      Future.delayed(Duration.zero, () {
        employeeProvider.callgetEmployees();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    employeeProvider = Provider.of<EmployeeProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ServiceRequestDetailsScreen(
              index: widget.index,
              id: widget.data.id!.toInt(),
            ),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtendedImage.network(
            widget.data.user!.imageUri!,
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
                    widget.data.user!.imageUri!,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.k06,
                      border: Border.all(
                        color: widget.data.serviceType == 0
                            ? const Color(0xffD3ADF7)
                            : const Color(0xFFFFD591),
                      ),
                      color: widget.data.serviceType == 0
                          ? const Color(0xFFF9F0FF)
                          : const Color(0xFFFFF7E6),
                    ),
                    child: Text(
                      widget.data.serviceType == 0
                          ? getTranslated(context, LangConst.home).toString()
                          : getTranslated(context, LangConst.shop).toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: widget.data.serviceType == 0
                              ? const Color(0xFF9254DE)
                              : const Color(0xFFFA8C16),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    "${widget.data.bookingId}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.subText),
                  ),
                ],
              ),
              const HeightBox(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.data.user!.name}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.bodyText,
                        ),
                  ),
                  Text(
                    "${widget.data.currency} ${widget.data.amount}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  )
                ],
              ),
              Text(
                "${widget.data.address}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.subText,
                    ),
              ),
              widget.data.status == 0
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showRejectDialog(context);
                            },
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
                            onPressed: () {
                              employeeProvider.selectedEmployeeId = null;
                              showEmployeeDialog(
                                  context, employeeProvider.employees);
                            },
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
                  : const SizedBox()
            ],
          ))
        ],
      ),
    );
  }

  showEmployeeDialog(BuildContext context, List<EmployeeData> employees) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.white,
            backgroundColor: AppColors.white,
            title: Text(
              getTranslated(context, LangConst.employee).toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            actionsPadding: const EdgeInsets.only(bottom: 10, right: 16),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) =>
                            const HeightBox(5),
                        itemCount: employees.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          EmployeeData data = employees[index];
                          // return ListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          //   selected: employeeProvider.selectedEmployeeId == data.id!.toInt(),
                          //   onTap: () {
                          //     setState(() {
                          //       employeeProvider.selectedEmployeeId = data.id!.toInt();
                          //     });
                          //   },
                          //   selectedTileColor: AppColors.primary,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: AppBorderRadius.k08,
                          //   ),
                          //   title: Text(
                          //     data.name!,
                          //     style: Theme.of(context).textTheme.bodyMedium,
                          //   ),
                          // );
                          return RadioListTile(
                            value: data.id,
                            groupValue: employeeProvider.selectedEmployeeId,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(data.name!),
                            onChanged: (value) {
                              setState(() {
                                employeeProvider.selectedEmployeeId =
                                    value!.toInt();
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: Text(
                  getTranslated(context, LangConst.back).toString(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (employeeProvider.selectedEmployeeId == null) {
                    DeviceUtils.toastMessage("Please Select Employee");
                  } else {
                    if (kDebugMode) {
                      print(widget.data.id);
                      print(employeeProvider.selectedEmployeeId);
                    }
                    Map<String, dynamic> body = {
                      "employee_id": employeeProvider.selectedEmployeeId,
                      "status": 1,
                    };
                    Provider.of<ServiceRequestProvider>(context, listen: false)
                        .callUpdateBooking(
                            widget.data.id!.toInt(), body, "approved");
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  getTranslated(context, LangConst.ok).toString(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  showRejectDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.white,
            backgroundColor: AppColors.white,
            title: Text(
              getTranslated(context, LangConst.reject).toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            actionsPadding: const EdgeInsets.only(bottom: 10, right: 16),
            content: Text(
                getTranslated(context, LangConst.areYouSureToRejectThis)
                    .toString()),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: Text(
                  getTranslated(context, LangConst.back).toString(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> body = {
                    "status": 5,
                  };
                  Provider.of<ServiceRequestProvider>(context, listen: false)
                      .callUpdateBooking(
                          widget.data.id!.toInt(), body, "reject");
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: Text(
                  getTranslated(context, LangConst.ok).toString(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
