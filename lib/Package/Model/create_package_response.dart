import 'package:voyzo_vendor/Package/Model/packages_response.dart';

class CreatePackageResponse {
  CreatePackageResponse({
    String? msg,
    PackageData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  CreatePackageResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? PackageData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  PackageData? _data;
  bool? _success;

  CreatePackageResponse copyWith({
    String? msg,
    PackageData? data,
    bool? success,
  }) =>
      CreatePackageResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  PackageData? get data => _data;

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
