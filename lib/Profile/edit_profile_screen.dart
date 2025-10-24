import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Profile/Provider/profile_provider.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Utils/preferences_names.dart';
import 'package:voyzo_vendor/Utils/shared_preferences.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:voyzo_vendor/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyChangePassword = GlobalKey<FormState>();

  ///Current Password Controller & Focus Node & Obscure

  late FocusNode currentPasswordFocusNode;
  bool _isObscureTextCurrentPassword = true;

  ///new Password Controller & Focus Node & Obscure

  late FocusNode newPasswordFocusNode;
  bool _isObscureTextNewPassword = true;

  ///Confirm Password Controller & Focus Node & Obscure

  late FocusNode confirmFocusNode;
  bool _isObscureConfirmText = true;

  late ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.userNameFocusNode = FocusNode();
    profileProvider.emailFocusNode = FocusNode();
    profileProvider.phoneNumberFocusNode = FocusNode();
    currentPasswordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    confirmFocusNode = FocusNode();
  }

  @override
  void dispose() {
    profileProvider.currentPasswordController.text = "";
    profileProvider.newPasswordController.text = "";
    profileProvider.confirmPasswordController.text = "";

    profileProvider.userNameFocusNode.dispose();
    profileProvider.emailFocusNode.dispose();
    profileProvider.phoneNumberFocusNode.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: profileProvider.settingLoader,
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
            getTranslated(context, LangConst.editProfile).toString(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///profile image
              Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: ExtendedImage.network(
                        SharedPreferenceHelper.getString(
                            PreferencesNames.imageUrl),
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
                                SharedPreferenceHelper.getString(
                                    PreferencesNames.imageUrl),
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.hardEdge,
                                fit: BoxFit.cover,
                                shape: BoxShape.circle,
                              );
                            case LoadState.failed:
                              return Image.asset("assets/app/profile.png");
                          }
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 60),
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          profileProvider.chooseProfileImage(context);
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
                            )),
                      ),
                    ),
                  )
                ],
              ),

              ///Edit profile
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(context, LangConst.editProfile)
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const HeightBox(20),
                      TextFormField(
                        focusNode: profileProvider.userNameFocusNode,
                        controller: profileProvider.userNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: getTranslated(context, LangConst.fullName)
                              .toString(),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor: profileProvider.userNameFocusNode.hasFocus
                              ? AppColors.primary.withAlpha(40)
                              : Colors.white,
                        ),
                      ),
                      const HeightBox(15),
                      TextFormField(
                        readOnly: true,
                        focusNode: profileProvider.emailFocusNode,
                        controller: profileProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          // To prevent space
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z0-9@.]+")),
                          // To allow only email valid characters
                        ],
                        decoration: InputDecoration(
                          labelText:
                              getTranslated(context, LangConst.emailLabel)
                                  .toString(),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor: profileProvider.emailFocusNode.hasFocus
                              ? AppColors.primary.withAlpha(40)
                              : Colors.white,
                        ),
                      ),
                      const HeightBox(15),
                      TextFormField(
                        focusNode: profileProvider.phoneNumberFocusNode,
                        controller: profileProvider.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                        inputFormatters: const [],
                        decoration: InputDecoration(
                          labelText:
                              getTranslated(context, LangConst.phoneNumber)
                                  .toString(),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor:
                              profileProvider.phoneNumberFocusNode.hasFocus
                                  ? AppColors.primary.withAlpha(40)
                                  : Colors.white,
                        ),
                      ),
                      const HeightBox(40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> body = {
                              "name": profileProvider.userNameController.text,
                              "phone_no":
                                  profileProvider.phoneNumberController.text
                            };
                            profileProvider.callUpdateProfile(body);
                          }
                        },
                        style: AppButtonStyle.filledMedium.copyWith(
                            minimumSize: MaterialStatePropertyAll(
                                Size(MediaQuery.of(context).size.width, 50))),
                        child: Text(
                          getTranslated(context, LangConst.saveLabel)
                              .toString(),
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

              ///change Password
              Form(
                key: _formKeyChangePassword,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(context, LangConst.changePassword)
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const HeightBox(20),
                      TextFormField(
                        focusNode: currentPasswordFocusNode,
                        controller: profileProvider.currentPasswordController,
                        obscureText: _isObscureTextCurrentPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter current password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText:
                              getTranslated(context, LangConst.currentPassword)
                                  .toString(),
                          filled: true,
                          fillColor: currentPasswordFocusNode.hasFocus
                              ? AppColors.primary.withAlpha(40)
                              : Colors.white,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isObscureTextCurrentPassword =
                                    !_isObscureTextCurrentPassword;
                              });
                            },
                            child: Icon(
                              _isObscureTextCurrentPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const HeightBox(15),
                      TextFormField(
                        focusNode: newPasswordFocusNode,
                        controller: profileProvider.newPasswordController,
                        obscureText: _isObscureTextNewPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter new password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText:
                              getTranslated(context, LangConst.newPassword)
                                  .toString(),
                          filled: true,
                          fillColor: newPasswordFocusNode.hasFocus
                              ? AppColors.primary.withAlpha(40)
                              : Colors.white,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isObscureTextNewPassword =
                                    !_isObscureTextNewPassword;
                              });
                            },
                            child: Icon(
                              _isObscureTextNewPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const HeightBox(15),
                      TextFormField(
                        focusNode: confirmFocusNode,
                        controller: profileProvider.confirmPasswordController,
                        obscureText: _isObscureConfirmText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter confirm password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText:
                              getTranslated(context, LangConst.confirmPassword)
                                  .toString(),
                          filled: true,
                          fillColor: confirmFocusNode.hasFocus
                              ? AppColors.primary.withAlpha(40)
                              : Colors.white,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isObscureConfirmText = !_isObscureConfirmText;
                              });
                            },
                            child: Icon(
                              _isObscureConfirmText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const HeightBox(40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKeyChangePassword.currentState!.validate()) {
                            Map<String, dynamic> body = {
                              "old_password": profileProvider
                                  .currentPasswordController.text,
                              "password":
                                  profileProvider.newPasswordController.text,
                              "password_confirmation": profileProvider
                                  .confirmPasswordController.text,
                            };
                            profileProvider.callPasswordChange(body);
                          }
                        },
                        style: AppButtonStyle.filledMedium.copyWith(
                            minimumSize: MaterialStatePropertyAll(
                                Size(MediaQuery.of(context).size.width, 50))),
                        child: Text(
                          getTranslated(context, LangConst.changePassword)
                              .toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
