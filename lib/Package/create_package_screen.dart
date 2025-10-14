import 'package:carsnexus_owner/Home%20&%20Shops/create_shop_screen.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Package/Provider/package_provider.dart';
import 'package:carsnexus_owner/Services/Provider/service_provider.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Widgets/app_bar_back_icon.dart';
import 'package:carsnexus_owner/Widgets/constant_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreatePackageScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const CreatePackageScreen({super.key, required this.isEdit, this.id});

  @override
  State<CreatePackageScreen> createState() => _CreatePackageScreenState();
}

class _CreatePackageScreenState extends State<CreatePackageScreen> {
  late ServiceProvider serviceProvider;
  late PackageProvider packageProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    packageProvider = Provider.of<PackageProvider>(context, listen: false);

    for (int i = 0; i < serviceProvider.services.length; i++) {
      serviceProvider.services[i].isSelected = false;
    }
    if (widget.isEdit == true) {
      Future.delayed(Duration.zero, () {
        packageProvider.callSinglePackages(widget.id!, context);
      });
    }
    packageProvider.packageNameFocusNode = FocusNode();
    packageProvider.priceFocusNode = FocusNode();
    packageProvider.durationFocusNode = FocusNode();
    packageProvider.descriptionFocusNode = FocusNode();
    packageProvider.servicesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    packageProvider.packageNameController.text = "";
    packageProvider.packageNameFocusNode.dispose();

    packageProvider.priceController.text = "";
    packageProvider.priceFocusNode.dispose();

    packageProvider.durationController.text = "";
    packageProvider.durationFocusNode.dispose();

    packageProvider.descriptionController.text = "";
    packageProvider.descriptionFocusNode.dispose();

    packageProvider.servicesController.text = "";
    packageProvider.servicesFocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    serviceProvider = Provider.of<ServiceProvider>(context);
    packageProvider = Provider.of<PackageProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: packageProvider.createPackageLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        key: scaffoldKey,
        appBar: AppBar(
          leading: const AppBarBack(),
          title: Text(widget.isEdit == true
              ? getTranslated(context, LangConst.package).toString()
              : getTranslated(context, LangConst.createPackage).toString()),
          actions: [
            widget.isEdit == true
                ? InkWell(
                    onTap: () {
                      showDeleteDialog(context);
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 11, right: 11),
                      decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.k10,
                        color: AppColors.cancel.withAlpha(40),
                      ),
                      child: const Icon(
                        CupertinoIcons.delete,
                        size: 20,
                        color: AppColors.cancel,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Package name
                TextFormField(
                  focusNode: packageProvider.packageNameFocusNode,
                  controller: packageProvider.packageNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter package name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.packageName)
                        .toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: packageProvider.packageNameFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///price
                TextFormField(
                  focusNode: packageProvider.priceFocusNode,
                  controller: packageProvider.priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // To prevent space
                  ],
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.price).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: packageProvider.priceFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///Duration
                TextFormField(
                  focusNode: packageProvider.durationFocusNode,
                  controller: packageProvider.durationController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // To prevent space
                  ],
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.durationMinutes)
                        .toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: packageProvider.durationFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///services
                TextFormField(
                  focusNode: packageProvider.servicesFocusNode,
                  controller: packageProvider.servicesController,
                  readOnly: true,
                  onTap: () {
                    showSelectServiceDialog(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select services';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.services).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: packageProvider.servicesFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
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
                            color: packageProvider.status == Status.active
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      groupValue: packageProvider.status,
                      onChanged: (Status? value) {
                        setState(() {
                          packageProvider.status = value!;
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
                            color: packageProvider.status == Status.deactivate
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (Status? value) {
                        setState(() {
                          packageProvider.status = value!;
                        });
                      },
                      value: Status.deactivate,
                      groupValue: packageProvider.status,
                    )),
                  ],
                ),
                const HeightBox(15),

                ///Description
                TextFormField(
                  focusNode: packageProvider.descriptionFocusNode,
                  controller: packageProvider.descriptionController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.description)
                        .toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: packageProvider.descriptionFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(40),

                ///save button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit == false) {
                        Map<String, dynamic> body = {
                          "name": packageProvider.packageNameController.text,
                          "price": packageProvider.priceController.text,
                          "duration": packageProvider.durationController.text,
                          "description":
                              packageProvider.descriptionController.text,
                          "status": packageProvider.status.name.toLowerCase() ==
                                  "active"
                              ? 1
                              : 0,
                          "service": packageProvider.selectedServiceId,
                        };
                        if (kDebugMode) {
                          print(body);
                        }
                        packageProvider.callCreatePackages(body, context);
                      } else {
                        packageProvider.callUpdatePackages(
                          widget.id!,
                          packageProvider.selectedServiceId,
                          packageProvider.packageNameController.text,
                          num.parse(packageProvider.priceController.text),
                          packageProvider.descriptionController.text,
                          context,
                          packageProvider.status.name.toLowerCase() == "active"
                              ? 1
                              : 0,
                          num.parse(packageProvider.durationController.text),
                        );
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

  showSelectServiceDialog(BuildContext context) {
    if (widget.isEdit == true) {
      for (int i = 0; i < serviceProvider.services.length; i++) {
        for (int j = 0; j < packageProvider.editServiceId.length; j++) {
          if (serviceProvider.services[i].id ==
              packageProvider.editServiceId[j]) {
            serviceProvider.services[i].isSelected = true;
          }
        }
      }
    }
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.white,
            backgroundColor: AppColors.white,
            actionsPadding: const EdgeInsets.only(right: 16),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                itemCount: serviceProvider.services.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: serviceProvider.services[index].isSelected,
                    onChanged: (value) {
                      setState(() {
                        serviceProvider.services[index].isSelected = value!;
                      });
                    },
                    title: Text(serviceProvider.services[index].name!),
                  );
                },
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final servicesName = StringBuffer();
                  final servicesId = StringBuffer();
                  for (int i = 0; i < serviceProvider.services.length; i++) {
                    if (serviceProvider.services[i].isSelected == true) {
                      servicesName
                          .write("${serviceProvider.services[i].name!}, ");
                      servicesId
                          .write("${serviceProvider.services[i].id!.toInt()},");
                    }
                  }
                  packageProvider.selectedServiceId =
                      servicesId.toString().substring(0, servicesId.length - 1);
                  packageProvider.servicesController.text = servicesName
                      .toString()
                      .substring(0, servicesName.length - 1);
                  if (kDebugMode) {
                    print(packageProvider.selectedServiceId);
                    print(servicesName);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  getTranslated(context, LangConst.add).toString(),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: AppColors.white,
            shadowColor: AppColors.white,
            backgroundColor: AppColors.white,
            title: Text(
              getTranslated(context, LangConst.deleteQuestion).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.bodyText),
            ),
            actionsPadding: const EdgeInsets.only(bottom: 16, right: 16),
            content: Text(
              getTranslated(context, LangConst.areYouSureToDeleteThis)
                  .toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
                child: Text(
                  getTranslated(context, LangConst.cancelLabel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.bodyText,
                      ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  packageProvider
                      .callDeletePackage(widget.id!, context)
                      .whenComplete(() {
                    Navigator.of(scaffoldKey.currentState!.context).pop();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: Text(
                  getTranslated(context, LangConst.deleteLabel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
            ],
          );
        });
  }
}
