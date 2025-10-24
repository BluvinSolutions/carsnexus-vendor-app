import 'package:voyzo_vendor/Utils/device_utils.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';

class ServerError implements Exception {
  int? _errorCode;
  final String _errorMessage = "";

  ServerError.withError({error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException error) {
    if (error.response!.statusCode == 401) {
      if (error.response!.data['message'] != null) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return DeviceUtils.toastMessage(
            error.response!.data['message'].toString());
      } else if (error.response!.data['msg'] != null) {
        if (kDebugMode) {
          print(error.response!.data['msg'].toString());
        }
        return DeviceUtils.toastMessage(error.response!.data['msg'].toString());
      }
    } else if (error.response!.data['errors']['old_password'] != null) {
      return DeviceUtils.toastMessage(
          '${error.response!.data['errors']['old_password'][0]}');
    } else if (error.response!.data['errors']['password'] != null) {
      return DeviceUtils.toastMessage(
          '${error.response!.data['errors']['password'][0]}');
    } else if (error.response!.data['errors']['phone_no'] != null) {
      return DeviceUtils.toastMessage(
          '${error.response!.data['errors']['phone_no'][0]}');
    } else if (error.response!.data['errors']['email'] != null) {
      return DeviceUtils.toastMessage(
          '${error.response!.data['errors']['email'][0]}');
    } else if (error.type == DioExceptionType.badResponse) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage(error.response!.data['msg'].toString());
    } else if (error.type == DioExceptionType.unknown) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage(error.response!.data['msg'].toString());
    } else if (error.type == DioExceptionType.cancel) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage('Request was cancelled');
    } else if (error.type == DioExceptionType.connectionError) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage(
          'Connection failed. Please check internet connection');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage('Connection timeout');
    } else if (error.type == DioExceptionType.badCertificate) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage('${error.response!.data['msg']}');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage('Receive timeout in connection');
    } else if (error.type == DioExceptionType.sendTimeout) {
      if (kDebugMode) {
        print(error.response!.data['msg'].toString());
      }
      return DeviceUtils.toastMessage('Receive timeout in send request');
    }
    return _errorMessage;
  }
}
