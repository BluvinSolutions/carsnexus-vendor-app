import 'package:voyzo_vendor/Home%20&%20Shops/create_shop_screen.dart';
import 'package:voyzo_vendor/Network/api_header.dart';
import 'package:voyzo_vendor/Network/api_services.dart';
import 'package:voyzo_vendor/Network/base_model.dart';
import 'package:voyzo_vendor/Network/server_error.dart';
import 'package:voyzo_vendor/Services/Model/category_response.dart';
import 'package:voyzo_vendor/Services/Model/create_service_response.dart';
import 'package:voyzo_vendor/Services/Model/delete_response.dart';
import 'package:voyzo_vendor/Services/Model/services_response.dart';
import 'package:voyzo_vendor/Utils/device_utils.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  ///service name Controller & Focus Node
  TextEditingController serviceNameController = TextEditingController();
  late FocusNode serviceNameFocusNode;

  ///price Controller & Focus node
  TextEditingController priceController = TextEditingController();
  late FocusNode priceFocusNode;

  ///Duration Controller & Focus Node
  TextEditingController durationController = TextEditingController();
  late FocusNode durationFocusNode;

  ///description Controller & Focus Node
  TextEditingController descriptionController = TextEditingController();
  late FocusNode descriptionFocusNode;

  CategoryData? category;

  Status status = Status.active;

  bool createServiceLoader = false;
  List<CategoryData> categoryS = [];

  Future<BaseModel<CategoryResponse>> callgetCategory() async {
    CategoryResponse response;
    try {
      response = await ApiServices(ApiHeader().dioData()).category();
      if (response.success == true) {
        categoryS.clear();
        categoryS.addAll(response.data!);
        notifyListeners();
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateServiceResponse>> callCreateServices(
      Map<String, dynamic> body, BuildContext context) async {
    CreateServiceResponse response;
    try {
      createServiceLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).createServices(body);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        services.add(response.data!);
        if (context.mounted) Navigator.of(context).pop();
        notifyListeners();
      }
      createServiceLoader = false;
      notifyListeners();
    } catch (error) {
      createServiceLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<ServiceData> services = [];
  bool serviceLoader = false;

  Future<BaseModel<ServicesResponse>> callgetServices() async {
    ServicesResponse response;
    try {
      services.clear();
      serviceLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAllService();
      if (response.success == true) {
        services.addAll(response.data!);
        notifyListeners();
      }
      serviceLoader = false;
      notifyListeners();
    } catch (error) {
      serviceLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateServiceResponse>> callGetSingleServices(int id) async {
    CreateServiceResponse response;
    try {
      createServiceLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callSingleService(id);
      if (response.success == true) {
        serviceNameController.text = response.data!.name!;
        priceController.text = response.data!.price!.toString();
        durationController.text = response.data!.duration.toString();
        descriptionController.text = response.data!.description!;
        for (int i = 0; i < categoryS.length; i++) {
          if (response.data!.catId == categoryS[i].id) {
            category = categoryS[i];
            notifyListeners();
          }
        }
        status = response.data!.status == 1 ? Status.active : Status.deactivate;
        notifyListeners();
      }
      createServiceLoader = false;
      notifyListeners();
    } catch (error) {
      createServiceLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CreateServiceResponse>> callUpdateServices(
      int id,
      int catId,
      String name,
      num price,
      String description,
      int status,
      BuildContext context) async {
    CreateServiceResponse response;
    try {
      createServiceLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData())
          .callUpdateService(id, catId, name, price, description, status);
      if (response.success == true) {
        bool isExists =
            services.any((element) => element.id == response.data!.id!);
        if (isExists == true) {
          int index = services
              .indexWhere((element) => element.id == response.data!.id!);
          services.removeAt(index);
          services.insert(index, response.data!);
          notifyListeners();
          if (context.mounted) Navigator.of(context).pop();
        }
        notifyListeners();
      }
      createServiceLoader = false;
      notifyListeners();
    } catch (error) {
      createServiceLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<DeleteResponse>> callDeleteServices(
      int id, BuildContext context) async {
    DeleteResponse response;
    try {
      createServiceLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callDeleteService(
        id,
      );
      if (response.success == true) {
        bool isExists = services.any((element) => element.id == id);
        if (isExists == true) {
          int index = services.indexWhere((element) => element.id == id);
          services.removeAt(index);
        }
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        notifyListeners();
      }
      createServiceLoader = false;
      notifyListeners();
    } catch (error) {
      createServiceLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
