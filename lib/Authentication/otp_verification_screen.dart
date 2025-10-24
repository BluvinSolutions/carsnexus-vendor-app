import 'package:voyzo_vendor/Authentication/Provider/auth_provider.dart';
import 'package:voyzo_vendor/Localization/localization_constant.dart';
import 'package:voyzo_vendor/Theme/colors.dart';
import 'package:voyzo_vendor/Theme/theme.dart';
import 'package:voyzo_vendor/Utils/lang_const.dart';
import 'package:voyzo_vendor/Widgets/app_bar_back_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../Widgets/constant_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool newPassword;

  const OtpVerificationScreen(
      {super.key, required this.phoneNumber, required this.newPassword});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  late FocusNode otpFocusNode;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    otpFocusNode = FocusNode();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    otpController.dispose();

    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: authProvider.verifyMeLoader,
      opacity: 0.5,
      progressIndicator: const SpinKitPulsingGrid(
        color: AppColors.primary,
        size: 50.0,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const AppBarBack(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Amount.screenMargin),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightBox(25),
                Text(
                  getTranslated(context, LangConst.verification).toString(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  getTranslated(
                          context, LangConst.enterTheVerificationCodeBelow)
                      .toString(),
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.subText),
                ),
                const HeightBox(30),
                TextFormField(
                  focusNode: otpFocusNode,
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText:
                        getTranslated(context, LangConst.verificationCode)
                            .toString(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: otpFocusNode.hasFocus
                        ? AppColors.primary.withAlpha(40)
                        : Colors.white,
                  ),
                ),
                const HeightBox(40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        "phone_no": widget.phoneNumber,
                        "type": 1,
                        "OTP": otpController.text,
                      };
                      authProvider.callVerifyMe(
                          body, context, widget.newPassword);
                      if (kDebugMode) {
                        print(body);
                      }
                    }
                  },
                  style: AppButtonStyle.filledMedium.copyWith(
                      minimumSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width, 50))),
                  child: Text(
                    getTranslated(context, LangConst.verify).toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.white),
                  ),
                ),
                const HeightBox(30),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                        text: getTranslated(context, LangConst.doNotGetOTP)
                            .toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: getTranslated(context, LangConst.resend)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.primary),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ]),
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
