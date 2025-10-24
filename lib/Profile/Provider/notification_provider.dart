import 'package:voyzo_vendor/Network/api_header.dart';
import 'package:voyzo_vendor/Network/api_services.dart';
import 'package:voyzo_vendor/Network/base_model.dart';
import 'package:voyzo_vendor/Network/server_error.dart';
import 'package:voyzo_vendor/Profile/Model/notification_response.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationData> notifications = [];
  bool notificationLoader = false;

  Future<BaseModel<NotificationResponse>> callgetNotification() async {
    NotificationResponse response;
    try {
      notifications.clear();
      notificationLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetNotification();
      if (response.success == true) {
        notifications.addAll(response.data!);
        notifyListeners();
      }
      notificationLoader = false;
      notifyListeners();
    } catch (error) {
      notificationLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
