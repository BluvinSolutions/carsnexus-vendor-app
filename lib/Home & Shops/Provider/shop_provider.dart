import 'dart:convert';
import 'dart:io';

import 'package:carsnexus_owner/Home%20&%20Shops/Model/create_shop_response.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/create_shop_screen.dart';
import 'package:carsnexus_owner/Network/api_header.dart';
import 'package:carsnexus_owner/Network/api_services.dart';
import 'package:carsnexus_owner/Network/base_model.dart';
import 'package:carsnexus_owner/Network/server_error.dart';
import 'package:carsnexus_owner/Utils/device_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/shop_response.dart';

class ShopProvider extends ChangeNotifier {
  bool shopLoader = false;

  ///user name controller & Focus node
  TextEditingController shopNameController = TextEditingController();
  late FocusNode shopNameFocusNode;

  ///address controller & Focus node
  TextEditingController addressController = TextEditingController();
  late FocusNode addressFocusNode;

  ///phone number controller & Focus node
  TextEditingController phoneNumberController = TextEditingController();
  late FocusNode phoneNumberFocusNode;

  TextEditingController serviceController = TextEditingController();
  TextEditingController employeeController = TextEditingController();
  TextEditingController packageController = TextEditingController();

  ///start time controller
  TextEditingController startTimeController = TextEditingController();

  ///end time controller
  TextEditingController endTimeController = TextEditingController();

  List<ShopData> shops = [];

  Future<BaseModel<ShopResponse>> callGetShop() async {
    ShopResponse response;
    try {
      shopLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetShop();
      if (response.success == true) {
        shops = response.data!;
        notifyListeners();
      }
      shopLoader = false;
      notifyListeners();
    } catch (error) {
      shopLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  String selectedService = "";
  String selectedEmployee = "";
  String selectedPackage = "";
  String startTime = "";
  String endTime = "";

  bool shopCreateLoader = false;

  Future<BaseModel<CreateShopResponse>> callCreateShop(
      Map<String, dynamic> body, BuildContext context) async {
    CreateShopResponse response;
    try {
      shopCreateLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callCreateShop(body);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        shops.insert(0, response.data!);
        notifyListeners();
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      shopCreateLoader = false;
      notifyListeners();
    } catch (error) {
      shopCreateLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  var serviceTypes = ["Home", "Shop"];
  String? serviceType;
  Status status = Status.active;
  String shopImage = "";

  List editServiceId = [];
  List editPackageId = [];
  List editEmployeeId = [];

  Future<BaseModel<CreateShopResponse>> callGetSingleShop(int id) async {
    CreateShopResponse response;
    try {
      shopCreateLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callSingleShop(id);
      if (response.success == true) {
        shopNameController.text = response.data!.name ?? "";
        addressController.text = response.data!.address ?? "";
        phoneNumberController.text = response.data!.phoneNo ?? "";
        startTime = response.data!.startTime ?? "";
        endTime = response.data!.endTime ?? "";
        startTimeController.text = response.data!.startTime != null
            ? DeviceUtils.formatTime(response.data!.startTime!)
            : "";
        endTimeController.text = response.data!.endTime != null
            ? DeviceUtils.formatTime(response.data!.endTime!)
            : "";
        serviceType = response.data!.serviceType == 0 ? "Home" : "Shop";
        status = response.data!.status == 1 ? Status.active : Status.deactivate;
        shopImage = response.data!.imageUri ?? "";
        editServiceId.clear();
        editEmployeeId.clear();
        editPackageId.clear();

        ///package
        var packageItem = StringBuffer();
        final packageId = StringBuffer();
        for (int i = 0; i < response.data!.packageData!.length; i++) {
          packageItem.write("${response.data!.packageData![i].name!},");
          packageId.write("${response.data!.packageData![i].id!.toInt()},");
          editPackageId.add(response.data!.packageData![i].id);
        }
        packageController.text = response.data!.packageData!.isEmpty
            ? ""
            : packageItem.toString().substring(0, packageItem.length - 1);
        selectedPackage = response.data!.packageData!.isEmpty
            ? ""
            : packageId.toString().substring(0, packageId.length - 1);

        ///employee
        var employeeItem = StringBuffer();
        final employeeId = StringBuffer();
        for (int i = 0; i < response.data!.employeeData!.length; i++) {
          employeeItem.write("${response.data!.employeeData![i].name!},");
          employeeId.write("${response.data!.employeeData![i].id!.toInt()},");
          editEmployeeId.add(response.data!.employeeData![i].id);
        }
        employeeController.text =
            employeeItem.toString().substring(0, employeeItem.length - 1);
        selectedEmployee =
            employeeId.toString().substring(0, employeeId.length - 1);

        ///service

        var serviceItem = StringBuffer();
        final serviceId = StringBuffer();
        for (int i = 0; i < response.data!.serviceData!.length; i++) {
          serviceItem.write("${response.data!.serviceData![i].name!},");
          serviceId.write("${response.data!.serviceData![i].id!.toInt()},");
          editServiceId.add(response.data!.serviceData![i].id);
        }
        serviceController.text =
            serviceItem.toString().substring(0, serviceItem.length - 1);
        selectedService =
            serviceId.toString().substring(0, serviceId.length - 1);
        notifyListeners();
      }
      shopCreateLoader = false;
      notifyListeners();
    } catch (error) {
      shopCreateLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateShopResponse>> callUpdateShopWithPackage(
    int id,
    String name,
    String address,
    String phoneNumber,
    String startTime,
    String endTime,
    String employeeId,
    String serviceId,
    String packageId,
    int status,
    int serviceType,
    BuildContext context,
  ) async {
    CreateShopResponse response;
    try {
      shopCreateLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData())
          .callUpdateShopWithPackage(id, name, address, phoneNumber, startTime,
              endTime, serviceId, packageId, employeeId, status, serviceType);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        int index = shops.indexWhere((element) => element.id!.toInt() == id);
        shops.removeAt(index);
        shops.insert(index, response.data!);
        notifyListeners();
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      shopCreateLoader = false;
      notifyListeners();
    } catch (error) {
      shopCreateLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateShopResponse>> callUpdateShopWithOutPackage(
    int id,
    String name,
    String address,
    String phoneNumber,
    String startTime,
    String endTime,
    String employeeId,
    String serviceId,
    int status,
    int serviceType,
    BuildContext context,
  ) async {
    CreateShopResponse response;
    try {
      shopCreateLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData())
          .callUpdateShopWithoutPackage(id, name, address, phoneNumber,
              startTime, endTime, serviceId, employeeId, status, serviceType);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        int index = shops.indexWhere((element) => element.id!.toInt() == id);
        shops.removeAt(index);
        shops.insert(index, response.data!);
        notifyListeners();
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      shopCreateLoader = false;
      notifyListeners();
    } catch (error) {
      shopCreateLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateShopResponse>> callUpdateShopWithImagePackage(
      int id,
      String name,
      String address,
      String phoneNumber,
      String startTime,
      String endTime,
      String employeeId,
      String serviceId,
      int status,
      int serviceType,
      BuildContext context,
      String imageUrl) async {
    CreateShopResponse response;
    try {
      shopCreateLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData())
          .callUpdateShopWithImagePackage(
              id,
              name,
              address,
              phoneNumber,
              startTime,
              endTime,
              serviceId,
              employeeId,
              status,
              serviceType,
              imageUrl);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        proImage = null;
        image = "";
        int index = shops.indexWhere((element) => element.id!.toInt() == id);
        shops.removeAt(index);
        shops.insert(index, response.data!);
        notifyListeners();
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      shopCreateLoader = false;
      notifyListeners();
    } catch (error) {
      shopCreateLoader = false;
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
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    notifyListeners();
  }
}
