import 'package:carsnexus_owner/Home%20&%20Shops/create_shop_screen.dart';
import 'package:carsnexus_owner/Network/api_header.dart';
import 'package:carsnexus_owner/Network/api_services.dart';
import 'package:carsnexus_owner/Network/base_model.dart';
import 'package:carsnexus_owner/Network/server_error.dart';
import 'package:carsnexus_owner/Package/Model/create_package_response.dart';
import 'package:carsnexus_owner/Package/Model/packages_response.dart';
import 'package:carsnexus_owner/Services/Model/delete_response.dart';
import 'package:carsnexus_owner/Utils/device_utils.dart';
import 'package:flutter/material.dart';

class PackageProvider extends ChangeNotifier {
  ///service name Controller & Focus Node
  TextEditingController packageNameController = TextEditingController();
  late FocusNode packageNameFocusNode;

  ///price Controller & Focus node
  TextEditingController priceController = TextEditingController();
  late FocusNode priceFocusNode;

  ///Duration Controller & Focus Node
  TextEditingController durationController = TextEditingController();
  late FocusNode durationFocusNode;

  ///description Controller & Focus Node
  TextEditingController descriptionController = TextEditingController();
  late FocusNode descriptionFocusNode;

  ///Service Controller & Focus Node
  TextEditingController servicesController = TextEditingController();
  late FocusNode servicesFocusNode;

  List<PackageData> packages = [];

  Future<BaseModel<PackagesResponse>> callgetPackages() async {
    PackagesResponse response;
    try {
      response = await ApiServices(ApiHeader().dioData()).callGetPackages();
      if (response.success == true) {
        packages.clear();
        packages.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool createPackageLoader = false;
  String selectedServiceId = "";

  Future<BaseModel<CreatePackageResponse>> callCreatePackages(
      Map<String, dynamic> body, BuildContext context) async {
    CreatePackageResponse response;
    try {
      createPackageLoader = true;
      notifyListeners();
      response =
          await ApiServices(ApiHeader().dioData()).callCreatePackage(body);
      if (response.success == true) {
        packages.add(response.data!);
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      createPackageLoader = false;
      notifyListeners();
    } catch (error) {
      createPackageLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Status status = Status.active;
  List editServiceId = [];

  Future<BaseModel<CreatePackageResponse>> callSinglePackages(
      int id, BuildContext context) async {
    CreatePackageResponse response;
    try {
      createPackageLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callSinglePackage(id);
      if (response.success == true) {
        packageNameController.text = response.data!.name ?? "";
        priceController.text = response.data!.price.toString();
        durationController.text = response.data!.duration!.toString();
        descriptionController.text = response.data!.description ?? "";
        status = response.data!.status == 1 ? Status.active : Status.deactivate;
        final serviceItems = StringBuffer();
        final servicesId = StringBuffer();
        editServiceId.clear();
        for (int i = 0; i < response.data!.serviceData!.length; i++) {
          serviceItems.write("${response.data!.serviceData![i].name!},");
          servicesId.write("${response.data!.serviceData![i].id!.toInt()},");
          editServiceId.add(response.data!.serviceData![i].id);
        }
        servicesController.text =
            serviceItems.toString().substring(0, serviceItems.length - 1);
        selectedServiceId =
            servicesId.toString().substring(0, servicesId.length - 1);
        notifyListeners();
      }
      createPackageLoader = false;
      notifyListeners();
    } catch (error) {
      createPackageLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreatePackageResponse>> callUpdatePackages(
      int id,
      String service,
      String name,
      num price,
      String description,
      BuildContext context,
      int status,
      num duration) async {
    CreatePackageResponse response;
    try {
      createPackageLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callUpdatePackage(
          id, service, name, price, description, status, duration);
      if (response.success == true) {
        bool isExists =
            packages.any((element) => element.id == response.data!.id!);
        if (isExists == true) {
          int index = packages
              .indexWhere((element) => element.id == response.data!.id!);
          packages.removeAt(index);
          packages.insert(index, response.data!);
          notifyListeners();
        }
        notifyListeners();
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      createPackageLoader = false;
      notifyListeners();
    } catch (error) {
      createPackageLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<DeleteResponse>> callDeletePackage(
      int id, BuildContext context) async {
    DeleteResponse response;
    try {
      createPackageLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callDeletePackage(
        id,
      );
      if (response.success == true) {
        bool isExists = packages.any((element) => element.id == id);
        if (isExists == true) {
          int index = packages.indexWhere((element) => element.id == id);
          packages.removeAt(index);
        }
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        notifyListeners();
      }
      createPackageLoader = false;
      notifyListeners();
    } catch (error) {
      createPackageLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
