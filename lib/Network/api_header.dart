import 'package:voyzo_vendor/Utils/preferences_names.dart';
import 'package:voyzo_vendor/Utils/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiHeader {
  Dio dioData() {
    final dio = Dio();
    dio.options.headers["Accept"] =
        "application/json"; // Config your dio headers globally
    dio.options.headers["Authorization"] =
        "Bearer ${SharedPreferenceHelper.getString(PreferencesNames.authToken)}";
    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(seconds: 30); //5ss
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  }
}
