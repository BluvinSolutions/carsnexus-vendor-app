import 'package:carsnexus_owner/Home%20&%20Shops/create_shop_screen.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Services/Model/category_response.dart';
import 'package:carsnexus_owner/Services/Provider/service_provider.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/device_utils.dart';
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

class CreateServiceScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const CreateServiceScreen({super.key, required this.isEdit, this.id});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  late ServiceProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.serviceNameFocusNode = FocusNode();
    serviceProvider.priceFocusNode = FocusNode();
    serviceProvider.durationFocusNode = FocusNode();
    serviceProvider.descriptionFocusNode = FocusNode();

    Future.delayed(Duration.zero, () {
      if (widget.isEdit == true) {
        Future.delayed(const Duration(seconds: 1), () {
          serviceProvider.callGetSingleServices(widget.id!);
        });
      }
    });
  }

  @override
  void dispose() {
    serviceProvider.serviceNameController.text = "";
    serviceProvider.serviceNameFocusNode.dispose();

    serviceProvider.priceController.text = "";
    serviceProvider.priceFocusNode.dispose();

    serviceProvider.durationController.text = "";
    serviceProvider.durationFocusNode.dispose();

    serviceProvider.descriptionController.text = "";
    serviceProvider.descriptionFocusNode.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    serviceProvider = Provider.of<ServiceProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: serviceProvider.createServiceLoader,
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
              ? getTranslated(context, LangConst.service).toString()
              : getTranslated(context, LangConst.createService).toString()),
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
                ///Service name
                TextFormField(
                  focusNode: serviceProvider.serviceNameFocusNode,
                  controller: serviceProvider.serviceNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter service name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.serviceName)
                        .toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: serviceProvider.serviceNameFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///price
                TextFormField(
                  focusNode: serviceProvider.priceFocusNode,
                  controller: serviceProvider.priceController,
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
                    fillColor: serviceProvider.priceFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///Duration
                TextFormField(
                  focusNode: serviceProvider.durationFocusNode,
                  controller: serviceProvider.durationController,
                  keyboardType: TextInputType.number,
                  readOnly: widget.isEdit == true,
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
                    fillColor: serviceProvider.durationFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///category
                widget.isEdit == true && serviceProvider.category == null
                    ? const SizedBox()
                    : FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              errorStyle: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<CategoryData>(
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.bodyText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                hint: Text(
                                  getTranslated(context, LangConst.category)
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.subText,
                                        fontSize: 14,
                                      ),
                                ),
                                value: serviceProvider.category,
                                isExpanded: true,
                                isDense: true,
                                onChanged: (CategoryData? newValue) {
                                  setState(() {
                                    serviceProvider.category = newValue!;
                                  });
                                },
                                items: serviceProvider.categoryS
                                    .map<DropdownMenuItem<CategoryData>>(
                                        (CategoryData valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(
                                      valueItem.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                            color: serviceProvider.status == Status.active
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      groupValue: serviceProvider.status,
                      onChanged: (Status? value) {
                        setState(() {
                          serviceProvider.status = value!;
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
                            color: serviceProvider.status == Status.deactivate
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (Status? value) {
                        setState(() {
                          serviceProvider.status = value!;
                        });
                      },
                      value: Status.deactivate,
                      groupValue: serviceProvider.status,
                    )),
                  ],
                ),
                const HeightBox(15),

                ///Description
                TextFormField(
                  focusNode: serviceProvider.descriptionFocusNode,
                  controller: serviceProvider.descriptionController,
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
                    fillColor: serviceProvider.descriptionFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(40),

                ///save button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (serviceProvider.category == null) {
                        DeviceUtils.toastMessage("Please select category");
                      } else {
                        if (widget.isEdit == false) {
                          Map<String, dynamic> body = {
                            "cat_id": serviceProvider.category!.id,
                            "name": serviceProvider.serviceNameController.text,
                            "price": serviceProvider.priceController.text,
                            "duration": serviceProvider.durationController.text,
                            "status":
                                serviceProvider.status.name.toLowerCase() ==
                                        "active"
                                    ? 1
                                    : 0,
                            "description":
                                serviceProvider.descriptionController.text,
                          };
                          if (kDebugMode) {
                            print(body);
                          }
                          serviceProvider.callCreateServices(body, context);
                        } else {
                          serviceProvider.callUpdateServices(
                              widget.id!,
                              serviceProvider.category!.id!.toInt(),
                              serviceProvider.serviceNameController.text,
                              num.parse(serviceProvider.priceController.text),
                              serviceProvider.descriptionController.text,
                              serviceProvider.status.name.toLowerCase() ==
                                      "active"
                                  ? 1
                                  : 0,
                              context);
                        }
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
                  getTranslated(context, LangConst.cancel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.bodyText,
                      ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  serviceProvider
                      .callDeleteServices(widget.id!, context)
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
