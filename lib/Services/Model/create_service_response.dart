import 'package:carsnexus_owner/Services/Model/services_response.dart';

class CreateServiceResponse {
  CreateServiceResponse({
    String? msg,
    ServiceData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  CreateServiceResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? ServiceData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  ServiceData? _data;
  bool? _success;

  CreateServiceResponse copyWith({
    String? msg,
    ServiceData? data,
    bool? success,
  }) =>
      CreateServiceResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  ServiceData? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (data != null) {
      map['data'] = _data!.toJson();
    }
    map['success'] = _success;
    return map;
  }
}
