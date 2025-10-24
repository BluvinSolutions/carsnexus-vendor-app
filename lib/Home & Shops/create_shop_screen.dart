import 'package:voyzo_vendor/Employee/Provider/employee_provider.dart';
import 'package:voyzo_vendor/Home%20&%20Shops/Provider/shop_provider.dart';
import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Package/Provider/package_provider.dart';
import 'package:voyzo_vendor/Services/Provider/service_provider.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateShopScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const CreateShopScreen({super.key, required this.isEdit, this.id});

  @override
  State<CreateShopScreen> createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<CreateShopScreen> {
  late ShopProvider shopProvider;
  late ServiceProvider serviceProvider;
  late EmployeeProvider employeeProvider;
  late PackageProvider packageProvider;

  @override
  void initState() {
    super.initState();
    shopProvider = Provider.of<ShopProvider>(context, listen: false);
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    packageProvider = Provider.of<PackageProvider>(context, listen: false);
    shopProvider.shopNameFocusNode = FocusNode();
    shopProvider.addressFocusNode = FocusNode();
    shopProvider.phoneNumberFocusNode = FocusNode();

    Future.delayed(Duration.zero, () {
      if (widget.isEdit == true) {
        shopProvider.callGetSingleShop(widget.id!);
      }
      serviceProvider.callgetServices();
      employeeProvider.callgetEmployees();
      packageProvider.callgetPackages();
      if (widget.isEdit == false) {
        shopProvider.employeeController.clear();
        shopProvider.packageController.clear();
        shopProvider.serviceController.clear();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    shopProvider.shopNameController.text = "";
    shopProvider.shopNameFocusNode.dispose();

    shopProvider.addressController.text = "";
    shopProvider.addressFocusNode.dispose();

    shopProvider.phoneNumberController.text = "";
    shopProvider.phoneNumberFocusNode.dispose();

    shopProvider.startTimeController.text = "";

    shopProvider.endTimeController.text = "";
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    shopProvider = Provider.of<ShopProvider>(context);
    serviceProvider = Provider.of<ServiceProvider>(context);
    employeeProvider = Provider.of<EmployeeProvider>(context);
    packageProvider = Provider.of<PackageProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: shopProvider.shopCreateLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: const AppBarBack(),
          title: Text(widget.isEdit == true
              ? getTranslated(context, LangConst.shop).toString()
              : getTranslated(context, LangConst.createShop).toString()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///shop image
                Stack(
                  children: [
                    widget.isEdit == true
                        ? Align(
                            alignment: Alignment.center,
                            child: shopProvider.proImage != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(
                                      shopProvider.proImage!,
                                    ),
                                  )
                                : ExtendedImage.network(
                                    shopProvider.shopImage,
                                    clipBehavior: Clip.hardEdge,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                    height: 100,
                                    width: 100,
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
                                            shopProvider.shopImage,
                                            width: 100,
                                            height: 100,
                                            clipBehavior: Clip.hardEdge,
                                            fit: BoxFit.cover,
                                            shape: BoxShape.circle,
                                          );
                                        case LoadState.failed:
                                          return Image.asset(
                                              "assets/app/profile.png");
                                      }
                                    },
                                  ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: shopProvider.proImage != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(
                                      shopProvider.proImage!,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage("assets/app/profile.png"),
                                  ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70, left: 60),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            shopProvider.chooseProfileImage(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: AppBorderRadius.k06,
                              color: AppColors.primary,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const HeightBox(35),

                ///shop name textField
                TextFormField(
                  focusNode: shopProvider.shopNameFocusNode,
                  controller: shopProvider.shopNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Shop name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.shopName).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: shopProvider.shopNameFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///address
                TextFormField(
                  focusNode: shopProvider.addressFocusNode,
                  controller: shopProvider.addressController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.address).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: shopProvider.addressFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///phone number
                TextFormField(
                  focusNode: shopProvider.phoneNumberFocusNode,
                  controller: shopProvider.phoneNumberController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // To prevent space
                  ],
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.phoneNumber)
                        .toString(),
                    filled: true,
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: shopProvider.phoneNumberFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///service
                TextFormField(
                  controller: shopProvider.serviceController,
                  readOnly: true,
                  onTap: () {
                    showServiceDialog(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select service';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.service).toString(),
                    filled: true,
                    counterText: "",
                    fillColor: AppColors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                const HeightBox(15),

                ///Employee
                TextFormField(
                  controller: shopProvider.employeeController,
                  readOnly: true,
                  onTap: () {
                    showEmployeeDialog(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select employee';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.employee).toString(),
                    filled: true,
                    fillColor: AppColors.white,
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                const HeightBox(15),

                ///Package
                TextFormField(
                  controller: shopProvider.packageController,
                  readOnly: true,
                  onTap: () {
                    showPackageDialog(context);
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.packages).toString(),
                    filled: true,
                    counterText: "",
                    fillColor: AppColors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                const HeightBox(15),

                ///start time
                TextFormField(
                  controller: shopProvider.startTimeController,
                  readOnly: true,
                  keyboardType: TextInputType.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.bodyText),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select start time';
                    }
                    return null;
                  },
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              // primary: MyColors.primary,
                              primary: Theme.of(context).colorScheme.primary,
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: Colors.black,
                            ),
                            //.dialogBackgroundColor:Colors.blue[900],
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedTime != null) {
                      shopProvider.startTime =
                          "${pickedTime.hour}:${pickedTime.minute}:${00}";
                      setState(() {
                        shopProvider.startTimeController.text = pickedTime
                            .format(context); //set the value of text field.
                      });
                    } else {}
                  },
                  decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.startTime)
                          .toString(),
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 20,
                        color: AppColors.icon,
                      )),
                ),
                const HeightBox(15),

                ///end time
                TextFormField(
                  controller: shopProvider.endTimeController,
                  readOnly: true,
                  keyboardType: TextInputType.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.bodyText),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select end time';
                    }
                    return null;
                  },
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              // primary: MyColors.primary,
                              primary: Theme.of(context).colorScheme.primary,
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: Colors.black,
                            ),
                            //.dialogBackgroundColor:Colors.blue[900],
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedTime != null) {
                      if (kDebugMode) {
                        if (context.mounted) print(pickedTime.format(context));
                      } //output 10:51 PM
                      shopProvider.endTime =
                          "${pickedTime.hour}:${pickedTime.minute}:${00}";
                      setState(() {
                        shopProvider.endTimeController.text = pickedTime
                            .format(context); //set the value of text field.
                      });
                    } else {}
                  },
                  decoration: InputDecoration(
                      labelText:
                          getTranslated(context, LangConst.endTime).toString(),
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 20,
                        color: AppColors.icon,
                      )),
                ),
                const HeightBox(15),

                ///Service type
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 15,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.bold,
                                  ),
                          hint: Text(
                            getTranslated(context, LangConst.serviceType)
                                .toString(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.subText,
                                      fontSize: 14,
                                    ),
                          ),
                          value: shopProvider.serviceType,
                          isExpanded: true,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              shopProvider.serviceType = newValue!;
                            });
                          },
                          items: shopProvider.serviceTypes
                              .map<DropdownMenuItem<String>>(
                                  (String valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const HeightBox(15),

                ///status
                Text(
                  getTranslated(context, LangConst.status).toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const HeightBox(8),
                Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                      value: Status.active,
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        getTranslated(context, LangConst.active).toString(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: shopProvider.status == Status.active
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      groupValue: shopProvider.status,
                      onChanged: (Status? value) {
                        setState(() {
                          shopProvider.status = value!;
                        });
                      },
                    )),
                    Expanded(
                        child: RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        getTranslated(context, LangConst.deActivate).toString(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: shopProvider.status == Status.deactivate
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (Status? value) {
                        setState(() {
                          shopProvider.status = value!;
                        });
                      },
                      value: Status.deactivate,
                      groupValue: shopProvider.status,
                    )),
                  ],
                ),
                const HeightBox(
                  40,
                ),

                ///save button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit == true) {
                        if (shopProvider.selectedPackage.isEmpty &&
                            shopProvider.proImage == null) {
                          Map<String, dynamic> body = {
                            "name": shopProvider.shopNameController.text,
                            "address": shopProvider.addressController.text,
                            "phone_no": shopProvider.phoneNumberController.text,
                            "employee_id": shopProvider.selectedEmployee,
                            "service_id": shopProvider.selectedService,
                            "start_time": shopProvider.startTime,
                            "end_time": shopProvider.endTime,
                            "service_type":
                                shopProvider.serviceType == "Home" ? 0 : 1,
                            "status": shopProvider.status.name.toLowerCase() ==
                                    "active"
                                ? 1
                                : 0,
                          };
                          if (kDebugMode) {
                            print(body);
                          }
                          shopProvider.callUpdateShopWithOutPackage(
                            widget.id!,
                            shopProvider.shopNameController.text,
                            shopProvider.addressController.text,
                            shopProvider.phoneNumberController.text,
                            shopProvider.startTime,
                            shopProvider.endTime,
                            shopProvider.selectedEmployee,
                            shopProvider.selectedService,
                            shopProvider.status.name.toLowerCase() == "active"
                                ? 1
                                : 0,
                            shopProvider.serviceType == "Home" ? 0 : 1,
                            context,
                          );
                        } else if (shopProvider.proImage != null) {
                          Map<String, dynamic> body = {
                            "name": shopProvider.shopNameController.text,
                            "address": shopProvider.addressController.text,
                            "phone_no": shopProvider.phoneNumberController.text,
                            "employee_id": shopProvider.selectedEmployee,
                            "service_id": shopProvider.selectedService,
                            "start_time": shopProvider.startTime,
                            "end_time": shopProvider.endTime,
                            "service_type":
                                shopProvider.serviceType == "Home" ? 0 : 1,
                            "status": shopProvider.status.name.toLowerCase() ==
                                    "active"
                                ? 1
                                : 0,
                            "image": shopProvider.image,
                          };
                          if (kDebugMode) {
                            print(body);
                          }
                          shopProvider.callUpdateShopWithImagePackage(
                            widget.id!,
                            shopProvider.shopNameController.text,
                            shopProvider.addressController.text,
                            shopProvider.phoneNumberController.text,
                            shopProvider.startTime,
                            shopProvider.endTime,
                            shopProvider.selectedEmployee,
                            shopProvider.selectedService,
                            shopProvider.status.name.toLowerCase() == "active"
                                ? 1
                                : 0,
                            shopProvider.serviceType == "Home" ? 0 : 1,
                            context,
                            "data:image/jpeg;base64,${shopProvider.image}",
                          );
                        } else {
                          Map<String, dynamic> body = {
                            "name": shopProvider.shopNameController.text,
                            "address": shopProvider.addressController.text,
                            "phone_no": shopProvider.phoneNumberController.text,
                            "employee_id": shopProvider.selectedEmployee,
                            "service_id": shopProvider.selectedService,
                            "package_id": shopProvider.selectedPackage,
                            "start_time": shopProvider.startTime,
                            "end_time": shopProvider.endTime,
                            "service_type":
                                shopProvider.serviceType == "Home" ? 0 : 1,
                            "status": shopProvider.status.name.toLowerCase() ==
                                    "active"
                                ? 1
                                : 0,
                          };
                          if (kDebugMode) {
                            print(body);
                          }
                          shopProvider.callUpdateShopWithPackage(
                            widget.id!,
                            shopProvider.shopNameController.text,
                            shopProvider.addressController.text,
                            shopProvider.phoneNumberController.text,
                            shopProvider.startTime,
                            shopProvider.endTime,
                            shopProvider.selectedEmployee,
                            shopProvider.selectedService,
                            shopProvider.selectedPackage,
                            shopProvider.status.name.toLowerCase() == "active"
                                ? 1
                                : 0,
                            shopProvider.serviceType == "Home" ? 0 : 1,
                            context,
                          );
                        }
                      } else {
                        Map<String, dynamic> body = {
                          "name": shopProvider.shopNameController.text,
                          "address": shopProvider.addressController.text,
                          "phone_no": shopProvider.phoneNumberController.text,
                          "employee_id": shopProvider.selectedEmployee,
                          "service_id": shopProvider.selectedService,
                          "start_time": shopProvider.startTime,
                          "end_time": shopProvider.endTime,
                          "service_type":
                              shopProvider.serviceType == "Home" ? 0 : 1,
                          "status":
                              shopProvider.status.name.toLowerCase() == "active"
                                  ? 1
                                  : 0,
                          if (shopProvider.proImage != null)
                            "image":
                                "data:image/jpeg;base64,${shopProvider.image}",
                          if (shopProvider.selectedPackage.isNotEmpty)
                            "package_id": shopProvider.selectedPackage,
                        };
                        if (kDebugMode) {
                          print(body);
                        }
                        shopProvider.callCreateShop(body, context);
                      }
                    }
                  },
                  style: AppButtonStyle.filledMedium.copyWith(
                      minimumSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width, 45))),
                  child: Text(
                    getTranslated(context, LangConst.saveLabel).toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showServiceDialog(BuildContext context) {
    if (widget.isEdit == true) {
      for (int i = 0; i < serviceProvider.services.length; i++) {
        for (int j = 0; j < shopProvider.editServiceId.length; j++) {
          if (serviceProvider.services[i].id == shopProvider.editServiceId[j]) {
            serviceProvider.services[i].isSelected = true;
          }
        }
      }
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogState) {
            return AlertDialog(
              surfaceTintColor: AppColors.white,
              shadowColor: AppColors.white,
              backgroundColor: AppColors.white,
              title: Text(
                getTranslated(context, LangConst.services).toString(),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: serviceProvider.services.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      value: serviceProvider.services[index].isSelected,
                      onChanged: (value) {
                        dialogState(() {
                          serviceProvider.services[index].isSelected = value!;
                        });
                      },
                      title: Text(
                        serviceProvider.services[index].name!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                ),
              ),
              actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.stroke),
                  child: Text(
                    getTranslated(context, LangConst.cancel).toString(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    var servicesId = StringBuffer();
                    var serviceName = StringBuffer();
                    for (int i = 0; i < serviceProvider.services.length; i++) {
                      if (serviceProvider.services[i].isSelected == true) {
                        serviceName
                            .write("${serviceProvider.services[i].name},");
                        servicesId.write("${serviceProvider.services[i].id},");
                      }
                    }
                    shopProvider.selectedService = servicesId.isNotEmpty
                        ? servicesId
                            .toString()
                            .substring(0, servicesId.length - 1)
                        : "";
                    shopProvider.serviceController.text = serviceName.isNotEmpty
                        ? serviceName
                            .toString()
                            .substring(0, serviceName.length - 1)
                        : "";
                    if (kDebugMode) {
                      print(shopProvider.selectedService);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(getTranslated(context, LangConst.ok).toString()),
                ),
              ],
            );
          });
        });
  }

  showEmployeeDialog(BuildContext context) {
    if (widget.isEdit == true) {
      for (int i = 0; i < employeeProvider.employees.length; i++) {
        for (int j = 0; j < shopProvider.editEmployeeId.length; j++) {
          if (employeeProvider.employees[i].id ==
              shopProvider.editEmployeeId[j]) {
            employeeProvider.employees[i].isSelected = true;
          }
        }
      }
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogState) {
            return AlertDialog(
              surfaceTintColor: AppColors.white,
              shadowColor: AppColors.white,
              backgroundColor: AppColors.white,
              title: Text(
                getTranslated(context, LangConst.employee).toString(),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: employeeProvider.employees.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      value: employeeProvider.employees[index].isSelected,
                      onChanged: (value) {
                        dialogState(() {
                          employeeProvider.employees[index].isSelected = value!;
                        });
                      },
                      title: Text(
                        employeeProvider.employees[index].name!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                ),
              ),
              actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.stroke),
                  child: Text(
                    getTranslated(context, LangConst.cancel).toString(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    var employeeId = StringBuffer();
                    var employeeName = StringBuffer();
                    for (int i = 0;
                        i < employeeProvider.employees.length;
                        i++) {
                      if (employeeProvider.employees[i].isSelected == true) {
                        employeeName
                            .write("${employeeProvider.employees[i].name},");
                        employeeId
                            .write("${employeeProvider.employees[i].id},");
                      }
                    }
                    shopProvider.selectedEmployee = employeeId.isNotEmpty
                        ? employeeId
                            .toString()
                            .substring(0, employeeId.length - 1)
                        : "";
                    shopProvider.employeeController.text =
                        employeeName.isNotEmpty
                            ? employeeName
                                .toString()
                                .substring(0, employeeName.length - 1)
                            : "";
                    if (kDebugMode) {
                      print(shopProvider.selectedEmployee);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    getTranslated(context, LangConst.ok).toString(),
                  ),
                ),
              ],
            );
          });
        });
  }

  showPackageDialog(BuildContext context) {
    if (widget.isEdit == true) {
      for (int i = 0; i < packageProvider.packages.length; i++) {
        for (int j = 0; j < shopProvider.editPackageId.length; j++) {
          if (packageProvider.packages[i].id == shopProvider.editPackageId[j]) {
            packageProvider.packages[i].isSelected = true;
          }
        }
      }
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogState) {
            return AlertDialog(
              surfaceTintColor: AppColors.white,
              shadowColor: AppColors.white,
              backgroundColor: AppColors.white,
              title: Text(
                getTranslated(context, LangConst.packages).toString(),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: packageProvider.packages.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      value: packageProvider.packages[index].isSelected,
                      onChanged: (value) {
                        dialogState(() {
                          packageProvider.packages[index].isSelected = value!;
                        });
                      },
                      title: Text(
                        packageProvider.packages[index].name!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                ),
              ),
              actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.stroke),
                  child: Text(
                    getTranslated(context, LangConst.cancel).toString(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    var packageId = StringBuffer();
                    var packageName = StringBuffer();
                    for (int i = 0; i < packageProvider.packages.length; i++) {
                      if (packageProvider.packages[i].isSelected == true) {
                        packageName
                            .write("${packageProvider.packages[i].name},");
                        packageId.write("${packageProvider.packages[i].id},");
                      }
                    }
                    shopProvider.selectedPackage = packageId.isNotEmpty
                        ? packageId
                            .toString()
                            .substring(0, packageId.length - 1)
                        : "";
                    shopProvider.packageController.text = packageName.isNotEmpty
                        ? packageName
                            .toString()
                            .substring(0, packageName.length - 1)
                        : "";
                    if (kDebugMode) {
                      print(shopProvider.selectedPackage);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    getTranslated(context, LangConst.ok).toString(),
                  ),
                ),
              ],
            );
          });
        });
  }
}

enum Status { active, deactivate }
