import 'dart:convert';
import 'dart:io';

import 'package:voyzo_vendor/Employee/Model/create_employee_response.dart';
import 'package:voyzo_vendor/Employee/Model/employees_response.dart';
import 'package:voyzo_vendor/Employee/Model/single_employee_profile_response.dart';
import 'package:voyzo_vendor/Home%20&%20Shops/create_shop_screen.dart';
import 'package:voyzo_vendor/Network/api_header.dart';
import 'package:voyzo_vendor/Network/api_services.dart';
import 'package:voyzo_vendor/Network/base_model.dart';
import 'package:voyzo_vendor/Network/server_error.dart';
import 'package:voyzo_vendor/Utils/device_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeProvider extends ChangeNotifier {
  ///name controller & Focus Node
  TextEditingController nameController = TextEditingController();
  late FocusNode nameFocusNode;

  ///email Controller & Focus Node
  TextEditingController emailController = TextEditingController();
  late FocusNode emailFocusNode;

  ///Phone number Controller & Focus Node
  TextEditingController phoneNumberController = TextEditingController();
  late FocusNode phoneNumberFocusNode;

  ///password Controller & Focus Node
  TextEditingController passwordController = TextEditingController();
  late FocusNode passwordFocusNode;

  ///Experience Controller & Focus Node
  TextEditingController experiencedController = TextEditingController();
  late FocusNode experienceFocusNode;

  ///Id Card Number Controller & Focus Node
  TextEditingController idCardNumberController = TextEditingController();
  late FocusNode idCardNumberFocusNode;

  ///start time Controller
  TextEditingController startTimeController = TextEditingController();

  ///end time Controller
  TextEditingController endTimeController = TextEditingController();

  String startTime = "";
  String endTime = "";

  List<EmployeeData> employees = [];
  bool employeeLoader = false;
  int? selectedEmployeeId;

  Future<BaseModel<EmployeesResponse>> callgetEmployees() async {
    EmployeesResponse response;
    try {
      employeeLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetEmployee();
      if (response.success == true) {
        employees.clear();
        employees.addAll(response.data!);
        notifyListeners();
      }
      employeeLoader = false;
      notifyListeners();
    } catch (error) {
      employeeLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool createEmployeeLoader = false;

  Future<BaseModel<CreateEmployeeResponse>> callCreateEmployee(
      Map<String, dynamic> body, BuildContext context) async {
    CreateEmployeeResponse response;
    try {
      createEmployeeLoader = true;
      notifyListeners();
      response =
          await ApiServices(ApiHeader().dioData()).callCreateEmployee(body);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        employees.add(response.data!);
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      createEmployeeLoader = false;
      notifyListeners();
    } catch (error) {
      createEmployeeLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Status status = Status.active;

  String employeeImage = "";
  List<Booking> employeeBooking = [];
  List<Reviews> employeeReviews = [];

  Future<BaseModel<SingleEmployeeProfileResponse>> callSingleEmployee(
      int id) async {
    SingleEmployeeProfileResponse response;
    try {
      createEmployeeLoader = true;
      notifyListeners();
      response =
          await ApiServices(ApiHeader().dioData()).callSingleEmployee(id);
      if (response.success == true) {
        nameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phoneNo ?? "";
        experiencedController.text = response.data!.experience ?? "";
        idCardNumberController.text = response.data!.idNo ?? "";
        startTimeController.text = response.data!.startTime ?? "";
        endTimeController.text = response.data!.endTime ?? "";
        startTime = response.data!.startTime ?? "";
        endTime = response.data!.endTime ?? "";
        status = response.data!.status == 1 ? Status.active : Status.deactivate;
        employeeImage = response.data!.imageUri ?? "";
        employeeBooking.clear();
        employeeBooking.addAll(response.data!.booking!);

        employeeReviews.clear();
        employeeReviews.addAll(response.data!.reviews!);
        notifyListeners();
      }
      createEmployeeLoader = false;
      notifyListeners();
    } catch (error) {
      createEmployeeLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateEmployeeResponse>> callUpdateEmployee(
      int id,
      String name,
      String phoneNumber,
      String experience,
      String idNumber,
      String startTime,
      String endTime,
      int status,
      BuildContext context) async {
    CreateEmployeeResponse response;
    try {
      createEmployeeLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callUpdateEmployee(id,
          name, phoneNumber, experience, idNumber, startTime, endTime, status);
      if (response.success == true) {
        bool isExists =
            employees.any((element) => element.id == response.data!.id!);
        if (isExists == true) {
          int index = employees
              .indexWhere((element) => element.id == response.data!.id!);
          employees.removeAt(index);
          employees.insert(index, response.data!);
          notifyListeners();
        }
        notifyListeners();
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      createEmployeeLoader = false;
      notifyListeners();
    } catch (error) {
      createEmployeeLoader = false;
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
