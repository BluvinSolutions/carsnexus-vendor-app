import 'package:voyzo_vendor/Services/Model/category_response.dart';

class ServicesResponse {
  ServicesResponse({
    dynamic msg,
    List<ServiceData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  ServicesResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<ServiceData>? _data;
  bool? _success;

  ServicesResponse copyWith({
    dynamic msg,
    List<ServiceData>? data,
    bool? success,
  }) =>
      ServicesResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<ServiceData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }
}

class ServiceData {
  ServiceData({
    num? id,
    num? ownerId,
    num? catId,
    String? name,
    String? description,
    num? duration,
    num? status,
    num? price,
    String? currency,
    CategoryData? category,
  }) {
    _id = id;
    _ownerId = ownerId;
    _catId = catId;
    _name = name;
    _description = description;
    _duration = duration;
    _status = status;
    _price = price;
    _currency = currency;
    _category = category;
  }

  ServiceData.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['owner_id'];
    _catId = json['cat_id'];
    _name = json['name'];
    _description = json['description'];
    _duration = json['duration'].runtimeType == String
        ? num.parse(json['duration'])
        : json['duration'];
    _status = json['status'];
    _price = json['price'].runtimeType == String
        ? num.parse(json['price'])
        : json['price'];
    _currency = json['currency'];
    _category = json['category'] != null
        ? CategoryData.fromJson(json['category'])
        : null;
  }

  num? _id;
  num? _ownerId;
  num? _catId;
  String? _name;
  String? _description;
  num? _duration;
  num? _status;
  num? _price;
  String? _currency;
  CategoryData? _category;

  ServiceData copyWith({
    num? id,
    num? ownerId,
    num? catId,
    String? name,
    String? description,
    num? duration,
    num? status,
    num? price,
    String? currency,
    CategoryData? category,
  }) =>
      ServiceData(
        id: id ?? _id,
        ownerId: ownerId ?? _ownerId,
        catId: catId ?? _catId,
        name: name ?? _name,
        description: description ?? _description,
        duration: duration ?? _duration,
        status: status ?? _status,
        price: price ?? _price,
        currency: currency ?? _currency,
        category: category ?? _category,
      );

  num? get id => _id;

  num? get ownerId => _ownerId;

  num? get catId => _catId;

  String? get name => _name;

  String? get description => _description;

  num? get duration => _duration;

  num? get status => _status;

  num? get price => _price;

  String? get currency => _currency;

  CategoryData? get category => _category;
  bool isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['owner_id'] = _ownerId;
    map['cat_id'] = _catId;
    map['name'] = _name;
    map['description'] = _description;
    map['duration'] = _duration;
    map['status'] = _status;
    map['price'] = _price;
    map['currency'] = _currency;
    if (category != null) {
      map['category'] = category!.toJson();
    }
    return map;
  }
}
