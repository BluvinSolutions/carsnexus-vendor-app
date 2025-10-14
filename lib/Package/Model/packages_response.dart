class PackagesResponse {
  PackagesResponse({
    dynamic msg,
    List<PackageData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  PackagesResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PackageData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<PackageData>? _data;
  bool? _success;

  PackagesResponse copyWith({
    dynamic msg,
    List<PackageData>? data,
    bool? success,
  }) =>
      PackagesResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<PackageData>? get data => _data;

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

class PackageData {
  PackageData({
    num? id,
    String? name,
    num? price,
    List<String>? service,
    num? ownerId,
    num? duration,
    num? status,
    String? description,
    String? currency,
    List<ServiceData>? serviceData,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _service = service;
    _ownerId = ownerId;
    _duration = duration;
    _status = status;
    _description = description;
    _currency = currency;
    _serviceData = serviceData;
  }

  PackageData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'].runtimeType == String
        ? num.parse(json['price'])
        : json['price'];
    _service = json['service'] != null ? json['service'].cast<String>() : [];
    _ownerId = json['owner_id'];
    _duration = json['duration'].runtimeType == String
        ? num.parse(json['duration'])
        : json['duration'];
    _status = json['status'].runtimeType == String
        ? num.parse(json['status'])
        : json['status'];
    _description = json['description'];
    _currency = json['currency'];
    if (json['serviceData'] != null) {
      _serviceData = [];
      json['serviceData'].forEach((v) {
        _serviceData?.add(ServiceData.fromJson(v));
      });
    }
  }

  num? _id;
  String? _name;
  num? _price;
  List<String>? _service;
  num? _ownerId;
  num? _duration;
  num? _status;
  String? _description;
  String? _currency;
  List<ServiceData>? _serviceData;

  PackageData copyWith({
    num? id,
    String? name,
    num? price,
    List<String>? service,
    num? ownerId,
    num? duration,
    num? status,
    String? description,
    String? currency,
    List<ServiceData>? serviceData,
  }) =>
      PackageData(
        id: id ?? _id,
        name: name ?? _name,
        price: price ?? _price,
        service: service ?? _service,
        ownerId: ownerId ?? _ownerId,
        duration: duration ?? _duration,
        status: status ?? _status,
        description: description ?? _description,
        currency: currency ?? _currency,
        serviceData: serviceData ?? _serviceData,
      );

  num? get id => _id;

  String? get name => _name;

  num? get price => _price;

  List<String>? get service => _service;

  num? get ownerId => _ownerId;

  num? get duration => _duration;

  num? get status => _status;

  String? get description => _description;

  String? get currency => _currency;

  List<ServiceData>? get serviceData => _serviceData;
  bool isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['service'] = _service;
    map['owner_id'] = _ownerId;
    map['duration'] = _duration;
    map['status'] = _status;
    map['description'] = _description;
    map['currency'] = _currency;
    if (_serviceData != null) {
      map['serviceData'] = _serviceData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ServiceData {
  ServiceData({
    String? name,
    num? id,
    String? currency,
  }) {
    _name = name;
    _id = id;
    _currency = currency;
  }

  ServiceData.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _currency = json['currency'];
  }

  String? _name;
  num? _id;
  String? _currency;

  ServiceData copyWith({
    String? name,
    num? id,
    String? currency,
  }) =>
      ServiceData(
        name: name ?? _name,
        id: id ?? _id,
        currency: currency ?? _currency,
      );

  String? get name => _name;

  num? get id => _id;

  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['currency'] = _currency;
    return map;
  }
}
