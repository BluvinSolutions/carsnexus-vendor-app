import 'package:voyzo_vendor/Authentication/model/forgot_response.dart';
import 'package:voyzo_vendor/Authentication/model/login_response.dart';
import 'package:voyzo_vendor/Authentication/model/register_response.dart';
import 'package:voyzo_vendor/Authentication/model/verify_me_response.dart';
import 'package:voyzo_vendor/Authentication/otp_verification_screen.dart';
import 'package:voyzo_vendor/Authentication/set_new_password_screen.dart';
import 'package:voyzo_vendor/Home%20&%20Shops/home_screen.dart';
import 'package:voyzo_vendor/Network/api_header.dart';
import 'package:voyzo_vendor/Network/api_services.dart';
import 'package:voyzo_vendor/Network/base_model.dart';
import 'package:voyzo_vendor/Network/server_error.dart';
import 'package:voyzo_vendor/Utils/device_utils.dart';
import 'package:voyzo_vendor/Utils/preferences_names.dart';
import 'package:voyzo_vendor/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool loginLoader = false;

  Future<BaseModel<LoginResponse>> callLoginApi(
      Map<String, dynamic> body, BuildContext context) async {
    LoginResponse response;
    try {
      loginLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callLoginApi(body);
      if (response.success == true) {
        SharedPreferenceHelper.setBoolean(PreferencesNames.isLogin, true);
        SharedPreferenceHelper.setString(
            PreferencesNames.authToken, response.data!.token ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.imageUrl, response.data!.imageUri!);
        SharedPreferenceHelper.setString(
            PreferencesNames.phoneNo, response.data!.phoneNo!);
        SharedPreferenceHelper.setString(
            PreferencesNames.userName, response.data!.name!);
        SharedPreferenceHelper.setString(
            PreferencesNames.email, response.data!.email!);
        if (context.mounted)
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      }
      loginLoader = false;
      notifyListeners();
    } catch (error) {
      loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool registerLoader = false;

  Future<BaseModel<RegisterResponse>> callRegisterApi(
      Map<String, dynamic> body, BuildContext context) async {
    RegisterResponse response;
    try {
      registerLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callRegisterApi(body);
      if (response.success == true) {
        if (response.flow == "verification" && response.data!.phoneNo != null) {
          if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                      phoneNumber: response.data!.phoneNo!,
                      newPassword: false,
                    )));
          }
        } else {
          if (context.mounted) Navigator.of(context).pop();
        }
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      }
      registerLoader = false;
      notifyListeners();
    } catch (error) {
      registerLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool verifyMeLoader = false;

  Future<BaseModel<VerifyMeResponse>> callVerifyMe(
      Map<String, dynamic> body, BuildContext context, bool newPassword) async {
    VerifyMeResponse response;
    try {
      verifyMeLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callVerifyMe(body);
      if (response.success == true) {
        SharedPreferenceHelper.setBoolean(PreferencesNames.isLogin, true);
        SharedPreferenceHelper.setString(
            PreferencesNames.authToken, response.data!.token ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.imageUrl, response.data!.imageUri!);
        SharedPreferenceHelper.setString(
            PreferencesNames.phoneNo, response.data!.phoneNo!);
        SharedPreferenceHelper.setString(
            PreferencesNames.userName, response.data!.name!);
        SharedPreferenceHelper.setString(
            PreferencesNames.email, response.data!.email!);
        if (newPassword == true) {
          if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SetNewPasswordScreen(
                      phoneNumber: response.data!.phoneNo ?? "",
                    )));
          }
        } else {
          if (context.mounted)
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      } else {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      }
      verifyMeLoader = false;
      notifyListeners();
    } catch (error) {
      verifyMeLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool setNewPassword = false;

  Future<BaseModel<LoginResponse>> callSetNewPassword(
      Map<String, dynamic> body, BuildContext context) async {
    LoginResponse response;
    try {
      setNewPassword = true;
      notifyListeners();
      response =
          await ApiServices(ApiHeader().dioData()).callSetNewPassword(body);
      if (response.success == true) {
        SharedPreferenceHelper.setBoolean(PreferencesNames.isLogin, true);
        SharedPreferenceHelper.setString(
            PreferencesNames.authToken, response.data!.token ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.imageUrl, response.data!.imageUri!);
        SharedPreferenceHelper.setString(
            PreferencesNames.phoneNo, response.data!.phoneNo!);
        SharedPreferenceHelper.setString(
            PreferencesNames.userName, response.data!.name!);
        SharedPreferenceHelper.setString(
            PreferencesNames.email, response.data!.email!);
        if (context.mounted)
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      } else {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      }
      setNewPassword = false;
      notifyListeners();
    } catch (error) {
      setNewPassword = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool forgotLoader = false;

  Future<BaseModel<ForgotResponse>> callForgotPassword(
      Map<String, dynamic> body) async {
    ForgotResponse response;
    try {
      forgotLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callForgotApi(body);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      } else {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
      }
      forgotLoader = false;
      notifyListeners();
    } catch (error) {
      forgotLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
