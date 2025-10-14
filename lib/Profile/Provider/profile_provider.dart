import 'dart:convert';
import 'dart:io';

import 'package:carsnexus_owner/Network/api_header.dart';
import 'package:carsnexus_owner/Network/api_services.dart';
import 'package:carsnexus_owner/Network/base_model.dart';
import 'package:carsnexus_owner/Network/server_error.dart';
import 'package:carsnexus_owner/Profile/Model/change_password_response.dart';
import 'package:carsnexus_owner/Profile/Model/profile_response.dart';
import 'package:carsnexus_owner/Utils/device_utils.dart';
import 'package:carsnexus_owner/Utils/preferences_names.dart';
import 'package:carsnexus_owner/Utils/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  ///user name controller & Focus node
  TextEditingController userNameController = TextEditingController();
  late FocusNode userNameFocusNode;

  ///email controller & Focus Node
  TextEditingController emailController = TextEditingController();
  late FocusNode emailFocusNode;

  ///Phone number Controller & Focus Node
  TextEditingController phoneNumberController = TextEditingController();
  late FocusNode phoneNumberFocusNode;

  bool settingLoader = false;
  bool isNotification = true;

  Future<BaseModel<ProfileResponse>> callgetProfile() async {
    ProfileResponse response;
    try {
      settingLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetProfile();
      if (response.success == true) {
        isNotification = response.data!.noti == 1 ? true : false;
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phoneNo ?? "";
        notifyListeners();
      }
      settingLoader = false;
      notifyListeners();
    } catch (error) {
      settingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ProfileResponse>> callUpdateProfile(
      Map<String, dynamic> body) async {
    ProfileResponse response;
    try {
      settingLoader = true;
      notifyListeners();
      response =
          await ApiServices(ApiHeader().dioData()).callUpdateProfile(body);
      if (response.success == true) {
        isNotification = response.data!.noti == 1 ? true : false;
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phoneNo ?? "";
        SharedPreferenceHelper.setString(
            PreferencesNames.phoneNo, response.data!.phoneNo ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.userName, response.data!.name ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.email, response.data!.email ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.imageUrl, response.data!.imageUri ?? "");
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        notifyListeners();
      }
      settingLoader = false;
      notifyListeners();
    } catch (error) {
      settingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ProfileResponse>> callUpdateProfilePicture(
      Map<String, dynamic> body) async {
    ProfileResponse response;
    try {
      settingLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData())
          .callUpdateProfilePicture(body);
      if (response.success == true) {
        isNotification = response.data!.noti == 1 ? true : false;
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phoneNo ?? "";
        SharedPreferenceHelper.setString(
            PreferencesNames.phoneNo, response.data!.phoneNo ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.userName, response.data!.name ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.email, response.data!.email ?? "");
        SharedPreferenceHelper.setString(
            PreferencesNames.imageUrl, response.data!.imageUri ?? "");
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        notifyListeners();
      }
      settingLoader = false;
      notifyListeners();
    } catch (error) {
      settingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  File? proImage;
  final picker = ImagePicker();
  String image = "";

  void chooseProfileImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text(
                    "From Gallery",
                  ),
                  onTap: () {
                    _proImgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text(
                  "From Camera",
                ),
                onTap: () {
                  _proImgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _proImgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      List<int> imageBytes = proImage!.readAsBytesSync();
      image = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        "image": "data:image/jpg;base64,$image",
      };
      callUpdateProfilePicture(body);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
  }

  void _proImgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      List<int> imageBytes = proImage!.readAsBytesSync();
      image = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        "image": "data:image/jpg;base64,$image",
      };
      callUpdateProfilePicture(body);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
  }

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<BaseModel<ChangePasswordResponse>> callPasswordChange(
      Map<String, dynamic> body) async {
    ChangePasswordResponse response;
    try {
      settingLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData())
          .callProfilePasswordUpdate(body);
      if (response.success == true) {
        SharedPreferenceHelper.setString(
            PreferencesNames.authToken, response.data ?? "");
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        notifyListeners();
      }
      settingLoader = false;
      notifyListeners();
    } catch (error) {
      settingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
