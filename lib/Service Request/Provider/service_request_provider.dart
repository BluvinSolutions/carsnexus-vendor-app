import 'package:voyzo_vendor/Network/api_header.dart';
import 'package:voyzo_vendor/Network/api_services.dart';
import 'package:voyzo_vendor/Network/server_error.dart';
import 'package:voyzo_vendor/Service%20Request/Model/booking_approved_response.dart';
import 'package:voyzo_vendor/Service%20Request/Model/service_request_response.dart';
import 'package:voyzo_vendor/Service%20Request/Model/single_request_response.dart';
import 'package:voyzo_vendor/Utils/device_utils.dart';
import 'package:flutter/material.dart';

import '../../Network/base_model.dart';

class ServiceRequestProvider extends ChangeNotifier {
  List<ServiceRequestData> waitingBooking = [];
  List<ServiceRequestData> approvedBooking = [];
  List<ServiceRequestData> completeBooking = [];
  List<ServiceRequestData> cancelBooking = [];

  bool bookingLoader = false;

  Future<BaseModel<ServiceRequestResponse>> callBookingRequest() async {
    ServiceRequestResponse response;
    try {
      waitingBooking.clear();
      approvedBooking.clear();
      completeBooking.clear();
      cancelBooking.clear();
      bookingLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetBooking();
      if (response.success == true) {
        if (response.data!.isNotEmpty && response.data != null) {
          for (int i = 0; i < response.data!.length; i++) {
            if (response.data![i].status == 0) {
              waitingBooking.add(response.data![i]);
            }
            if (response.data![i].status == 1) {
              approvedBooking.add(response.data![i]);
            }
            if (response.data![i].status == 2) {
              completeBooking.add(response.data![i]);
            }
            if (response.data![i].status == 3 ||
                response.data![i].status == 5) {
              cancelBooking.add(response.data![i]);
            }
          }
          notifyListeners();
        }
      }
      bookingLoader = false;
      notifyListeners();
    } catch (error) {
      bookingLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  bool singleLoader = false;
  SingleRequestData? singleRequestData;

  Future<BaseModel<SingleRequestResponse>> callSingleRequest(int id) async {
    SingleRequestResponse response;
    try {
      singleLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callSingleRequest(id);
      if (response.success == true) {
        singleRequestData = response.data!;
        notifyListeners();
      }
      singleLoader = false;
      notifyListeners();
    } catch (error) {
      singleLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<BookingApprovedResponse>> callUpdateBooking(
      int id, Map<String, dynamic> body, String status) async {
    BookingApprovedResponse response;
    try {
      response =
          await ApiServices(ApiHeader().dioData()).callUpdateBooking(id, body);
      if (response.success == true) {
        if (response.msg != null) {
          DeviceUtils.toastMessage(response.msg!);
        }
        if (status == "approved") {
          int index =
              waitingBooking.indexWhere((element) => element.id!.toInt() == id);
          waitingBooking[index].status = 1;
          approvedBooking.insert(0, waitingBooking[index]);
          waitingBooking.removeAt(index);
          notifyListeners();
        } else if (status == "reject") {
          int index =
              waitingBooking.indexWhere((element) => element.id!.toInt() == id);
          waitingBooking[index].status = 5;
          cancelBooking.insert(0, waitingBooking[index]);
          waitingBooking.removeAt(index);
          notifyListeners();
        }
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
