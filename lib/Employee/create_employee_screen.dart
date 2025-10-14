import 'package:carsnexus_owner/Employee/Provider/employee_provider.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/create_shop_screen.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Theme/colors.dart';
import 'package:carsnexus_owner/Theme/theme.dart';
import 'package:carsnexus_owner/Utils/lang_const.dart';
import 'package:carsnexus_owner/Widgets/app_bar_back_icon.dart';
import 'package:carsnexus_owner/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateEmployeeScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const CreateEmployeeScreen({super.key, required this.isEdit, this.id});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  bool _isObscureText = true;

  late EmployeeProvider employeeProvider;

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    if (widget.isEdit == true) {
      Future.delayed(Duration.zero, () {
        employeeProvider.callSingleEmployee(widget.id!);
      });
    }

    employeeProvider.nameFocusNode = FocusNode();
    employeeProvider.emailFocusNode = FocusNode();
    employeeProvider.phoneNumberFocusNode = FocusNode();
    employeeProvider.passwordFocusNode = FocusNode();
    employeeProvider.experienceFocusNode = FocusNode();
    employeeProvider.idCardNumberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    employeeProvider.nameController.text = "";
    employeeProvider.nameFocusNode.dispose();

    employeeProvider.emailController.text = "";
    employeeProvider.emailFocusNode.dispose();

    employeeProvider.phoneNumberController.text = "";
    employeeProvider.phoneNumberFocusNode.dispose();

    employeeProvider.passwordController.text = "";
    employeeProvider.passwordFocusNode.dispose();

    employeeProvider.experiencedController.text = "";
    employeeProvider.experienceFocusNode.dispose();

    employeeProvider.idCardNumberController.text = "";
    employeeProvider.idCardNumberFocusNode.dispose();

    employeeProvider.startTimeController.text = "";
    employeeProvider.endTimeController.text = "";
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
          title: Text(
            widget.isEdit == true
                ? getTranslated(context, LangConst.employee).toString()
                : getTranslated(context, LangConst.createEmployee).toString(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///profile image
                Stack(
                  children: [
                    widget.isEdit == true
                        ? Align(
                            alignment: Alignment.center,
                            child: ExtendedImage.network(
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
                                        "assets/app/profile.png");
                                }
                              },
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: employeeProvider.proImage != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(
                                      employeeProvider.proImage!,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      "assets/app/profile.png",
                                    ),
                                  ),
                          ),
                    widget.isEdit == true
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              top: 70,
                              left: 60,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  employeeProvider.chooseProfileImage(context);
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
                          ),
                  ],
                ),

                ///Name
                const HeightBox(30),
                TextFormField(
                  focusNode: employeeProvider.nameFocusNode,
                  controller: employeeProvider.nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.nameLabel).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: employeeProvider.nameFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///Email
                TextFormField(
                  focusNode: employeeProvider.emailFocusNode,
                  controller: employeeProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: widget.isEdit == true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r"\s"),
                    ), // To prevent space
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z0-9@.]+"),
                    ), // To allow only email valid characters
                  ],
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.emailLabel).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: employeeProvider.emailFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///phone number
                TextFormField(
                  focusNode: employeeProvider.phoneNumberFocusNode,
                  controller: employeeProvider.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.phoneNumber)
                        .toString(),
                    filled: true,
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: employeeProvider.phoneNumberFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///password
                Visibility(
                  visible: widget.isEdit == false,
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: employeeProvider.passwordFocusNode,
                        controller: employeeProvider.passwordController,
                        obscureText: _isObscureText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: getTranslated(context, LangConst.password)
                              .toString(),
                          filled: true,
                          fillColor: employeeProvider.passwordFocusNode.hasFocus
                              ? AppColors.primary.withAlpha(40)
                              : Colors.white,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isObscureText = !_isObscureText;
                              });
                            },
                            child: Icon(
                              _isObscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const HeightBox(15),
                    ],
                  ),
                ),

                ///experience
                TextFormField(
                  focusNode: employeeProvider.experienceFocusNode,
                  controller: employeeProvider.experiencedController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter experience';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.experience).toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: employeeProvider.experienceFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///id card number
                TextFormField(
                  focusNode: employeeProvider.idCardNumberFocusNode,
                  controller: employeeProvider.idCardNumberController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Id card number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.idCardNumber)
                        .toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: employeeProvider.idCardNumberFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(15),

                ///start time
                TextFormField(
                  controller: employeeProvider.startTimeController,
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
                      employeeProvider.startTime =
                          "${pickedTime.hour}:${pickedTime.minute}:${00}";
                      //output 10:51 PM
                      setState(() {
                        employeeProvider.startTimeController.text = pickedTime
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
                  controller: employeeProvider.endTimeController,
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
                      employeeProvider.endTime =
                          "${pickedTime.hour}:${pickedTime.minute}:${00}";
                      setState(() {
                        employeeProvider.endTimeController.text = pickedTime
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
                            color: employeeProvider.status == Status.active
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      groupValue: employeeProvider.status,
                      onChanged: (Status? value) {
                        setState(() {
                          employeeProvider.status = value!;
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
                            color: employeeProvider.status == Status.deactivate
                                ? AppColors.bodyText
                                : AppColors.subText,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (Status? value) {
                        setState(() {
                          employeeProvider.status = value!;
                        });
                      },
                      value: Status.deactivate,
                      groupValue: employeeProvider.status,
                    )),
                  ],
                ),
                const HeightBox(40),

                ///save button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit == false) {
                        Map<String, dynamic> body = {
                          "name": employeeProvider.nameController.text,
                          "email": employeeProvider.emailController.text,
                          "phone_no":
                              employeeProvider.phoneNumberController.text,
                          "password": employeeProvider.passwordController.text,
                          "experience":
                              employeeProvider.experiencedController.text,
                          "id_no": employeeProvider.idCardNumberController.text,
                          "start_time": employeeProvider.startTime,
                          "end_time": employeeProvider.endTime,
                          "status":
                              employeeProvider.status.name.toLowerCase() ==
                                      "active"
                                  ? 1
                                  : 0,
                          "image":
                              "data:image/jpeg;base64,${employeeProvider.image}",
                        };
                        employeeProvider.callCreateEmployee(body, context);
                        if (kDebugMode) {
                          print(body);
                        }
                      } else {
                        Map<String, dynamic> body = {
                          "name": employeeProvider.nameController.text,
                          "email": employeeProvider.emailController.text,
                          "phone_no":
                              employeeProvider.phoneNumberController.text,
                          "password": employeeProvider.passwordController.text,
                          "experience":
                              employeeProvider.experiencedController.text,
                          "id_no": employeeProvider.idCardNumberController.text,
                          "start_time": employeeProvider.startTime,
                          "end_time": employeeProvider.endTime,
                          "status":
                              employeeProvider.status.name.toLowerCase() ==
                                      "active"
                                  ? 1
                                  : 0,
                        };
                        employeeProvider.callUpdateEmployee(
                          widget.id!,
                          employeeProvider.nameController.text,
                          employeeProvider.phoneNumberController.text,
                          employeeProvider.experiencedController.text,
                          employeeProvider.idCardNumberController.text,
                          employeeProvider.startTime,
                          employeeProvider.endTime,
                          employeeProvider.status.name.toLowerCase() == "active"
                              ? 1
                              : 0,
                          context,
                        );
                        if (kDebugMode) {
                          print(body);
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
}
