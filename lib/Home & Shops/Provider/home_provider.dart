import 'package:voyzo_vendor/Home%20&%20Shops/Model/home_model.dart';
import 'package:voyzo_vendor/Network/api_header.dart';
import 'package:voyzo_vendor/Network/api_services.dart';
import 'package:voyzo_vendor/Network/base_model.dart';
import 'package:voyzo_vendor/Network/server_error.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool homeLoader = false;

  num todayWork = 0;
  num todayIncome = 0;
  num homeWork = 0;
  num homeIncome = 0;
  num shopWork = 0;
  num shopIncome = 0;

  String currency = "";

  Future<BaseModel<HomeModel>> callHomeApi() async {
    HomeModel response;
    try {
      homeLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callHomeApi();
      if (response.success == true) {
        currency = response.data!.currency!;
        todayWork = response.data!.data!;
        todayIncome = response.data!.income!;

        homeWork = response.data!.homeData!;
        homeIncome = response.data!.homeIncome!;

        shopWork = response.data!.shopData!;
        shopIncome = response.data!.shopIncome!;

        notifyListeners();
      }
      homeLoader = false;
      notifyListeners();
    } catch (error) {
      homeLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
