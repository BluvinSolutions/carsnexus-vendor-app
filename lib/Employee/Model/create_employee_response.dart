import 'package:carsnexus_owner/Employee/Model/employees_response.dart';

class CreateEmployeeResponse {
  CreateEmployeeResponse({
    String? msg,
    EmployeeData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  CreateEmployeeResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? EmployeeData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  EmployeeData? _data;
  bool? _success;

  CreateEmployeeResponse copyWith({
    String? msg,
    EmployeeData? data,
    bool? success,
  }) =>
      CreateEmployeeResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  EmployeeData? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}
