import 'package:carsnexus_owner/Home%20&%20Shops/Model/shop_response.dart';

class CreateShopResponse {
  CreateShopResponse({
    String? msg,
    ShopData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  CreateShopResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? ShopData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  ShopData? _data;
  bool? _success;

  CreateShopResponse copyWith({
    String? msg,
    ShopData? data,
    bool? success,
  }) =>
      CreateShopResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  ShopData? get data => _data;

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
