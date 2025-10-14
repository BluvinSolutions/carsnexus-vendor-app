class ServiceRequestResponse {
  ServiceRequestResponse({
    dynamic msg,
    List<ServiceRequestData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  ServiceRequestResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceRequestData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<ServiceRequestData>? _data;
  bool? _success;

  ServiceRequestResponse copyWith({
    dynamic msg,
    List<ServiceRequestData>? data,
    bool? success,
  }) =>
      ServiceRequestResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<ServiceRequestData>? get data => _data;

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

class ServiceRequestData {
  ServiceRequestData({
    num? id,
    String? startTime,
    String? endTime,
    num? status,
    String? address,
    num? shopId,
    num? vehicleId,
    num? serviceType,
    String? bookingId,
    num? userId,
    num? amount,
    String? currency,
    User? user,
    Shop? shop,
  }) {
    _id = id;
    _startTime = startTime;
    _endTime = endTime;
    _status = status;
    _address = address;
    _shopId = shopId;
    _vehicleId = vehicleId;
    _serviceType = serviceType;
    _bookingId = bookingId;
    _userId = userId;
    _amount = amount;
    _currency = currency;
    _user = user;
    _shop = shop;
  }

  ServiceRequestData.fromJson(dynamic json) {
    _id = json['id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _status = json['status'];
    _address = json['address'];
    _shopId = json['shop_id'];
    _vehicleId = json['vehicle_id'];
    _serviceType = json['service_type'];
    _bookingId = json['booking_id'];
    _userId = json['user_id'];
    _amount = json['amount'];
    _currency = json['currency'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  num? _id;
  String? _startTime;
  String? _endTime;
  num? _status;
  String? _address;
  num? _shopId;
  num? _vehicleId;
  num? _serviceType;
  String? _bookingId;
  num? _userId;
  num? _amount;
  String? _currency;
  User? _user;
  Shop? _shop;

  ServiceRequestData copyWith({
    num? id,
    String? startTime,
    String? endTime,
    num? status,
    String? address,
    num? shopId,
    num? vehicleId,
    num? serviceType,
    String? bookingId,
    num? userId,
    num? amount,
    String? currency,
    User? user,
    Shop? shop,
  }) =>
      ServiceRequestData(
        id: id ?? _id,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        status: status ?? _status,
        address: address ?? _address,
        shopId: shopId ?? _shopId,
        vehicleId: vehicleId ?? _vehicleId,
        serviceType: serviceType ?? _serviceType,
        bookingId: bookingId ?? _bookingId,
        userId: userId ?? _userId,
        amount: amount ?? _amount,
        currency: currency ?? _currency,
        user: user ?? _user,
        shop: shop ?? _shop,
      );

  num? get id => _id;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  // ignore: unnecessary_getters_setters
  num? get status => _status;

  set status(num? value) {
    _status = value;
  }

  String? get address => _address;

  num? get shopId => _shopId;

  num? get vehicleId => _vehicleId;

  num? get serviceType => _serviceType;

  String? get bookingId => _bookingId;

  num? get userId => _userId;

  num? get amount => _amount;

  String? get currency => _currency;

  User? get user => _user;

  Shop? get shop => _shop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['status'] = _status;
    map['address'] = _address;
    map['shop_id'] = _shopId;
    map['vehicle_id'] = _vehicleId;
    map['service_type'] = _serviceType;
    map['booking_id'] = _bookingId;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['currency'] = _currency;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }
    return map;
  }
}

class Shop {
  Shop({
    num? id,
    String? name,
    dynamic imageUri,
    String? avgRating,
  }) {
    _id = id;
    _name = name;
    _imageUri = imageUri;
    _avgRating = avgRating;
  }

  Shop.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageUri = json['imageUri'];
    _avgRating = json['avg_rating'].toString();
  }

  num? _id;
  String? _name;
  dynamic _imageUri;
  String? _avgRating;

  Shop copyWith({
    num? id,
    String? name,
    dynamic imageUri,
    String? avgRating,
  }) =>
      Shop(
        id: id ?? _id,
        name: name ?? _name,
        imageUri: imageUri ?? _imageUri,
        avgRating: avgRating ?? _avgRating,
      );

  num? get id => _id;

  String? get name => _name;

  dynamic get imageUri => _imageUri;

  String? get avgRating => _avgRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageUri'] = _imageUri;
    map['avg_rating'] = _avgRating;
    return map;
  }
}

class User {
  User({
    num? id,
    String? name,
    String? image,
    String? imageUri,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _imageUri = imageUri;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _imageUri = json['imageUri'];
  }

  num? _id;
  String? _name;
  String? _image;
  String? _imageUri;

  User copyWith({
    num? id,
    String? name,
    String? image,
    String? imageUri,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        imageUri: imageUri ?? _imageUri,
      );

  num? get id => _id;

  String? get name => _name;

  String? get image => _image;

  String? get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['imageUri'] = _imageUri;
    return map;
  }
}
