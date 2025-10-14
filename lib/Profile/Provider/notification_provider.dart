import 'package:carsnexus_owner/Network/api_header.dart';
import 'package:carsnexus_owner/Network/api_services.dart';
import 'package:carsnexus_owner/Network/base_model.dart';
import 'package:carsnexus_owner/Network/server_error.dart';
import 'package:carsnexus_owner/Profile/Model/notification_response.dart';
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
