import 'package:voyzo_vendor/Package/Model/packages_response.dart';

class ShopResponse {
  ShopResponse({
    dynamic msg,
    List<ShopData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  ShopResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ShopData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<ShopData>? _data;
  bool? _success;

  ShopResponse copyWith({
    dynamic msg,
    List<ShopData>? data,
    bool? success,
  }) =>
      ShopResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<ShopData>? get data => _data;

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

class ShopData {
  ShopData({
    num? id,
    num? ownerId,
    List<String>? serviceId,
    List<String>? packageId,
    List<String>? employeeId,
    String? name,
    String? address,
    String? image,
    String? phoneNo,
    num? isPopular,
    num? isBest,
    String? startTime,
    String? endTime,
    num? serviceType,
    num? status,
    String? imageUri,
    String? avgRating,
    List<PackageData>? packageData,
    List<ShopServiceData>? shopServiceData,
    List<ShopEmployeeData>? employeeData,
  }) {
    _id = id;
    _ownerId = ownerId;
    _serviceId = serviceId;
    _packageId = packageId;
    _employeeId = employeeId;
    _name = name;
    _address = address;
    _image = image;
    _phoneNo = phoneNo;
    _isPopular = isPopular;
    _isBest = isBest;
    _startTime = startTime;
    _endTime = endTime;
    _serviceType = serviceType;
    _status = status;
    _imageUri = imageUri;
    _avgRating = avgRating;
    _packageData = packageData;
    _serviceData = shopServiceData;
    _employeeData = employeeData;
  }

  ShopData.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['owner_id'];
    _serviceId =
        json['service_id'] != null ? json['service_id'].cast<String>() : [];
    _packageId =
        json['package_id'] != null ? json['package_id'].cast<String>() : [];
    _employeeId =
        json['employee_id'] != null ? json['employee_id'].cast<String>() : [];
    _name = json['name'];
    _address = json['address'];
    _image = json['image'];
    _phoneNo = json['phone_no'];
    _isPopular = json['is_popular'];
    _isBest = json['is_best'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _serviceType = json['service_type'];
    _status = json['status'];
    _imageUri = json['imageUri'];
    _avgRating = json['avg_rating'].toString();
    if (json['packageData'] != null) {
      _packageData = [];
      json['packageData'].forEach((v) {
        _packageData?.add(PackageData.fromJson(v));
      });
    }
    if (json['serviceData'] != null) {
      _serviceData = [];
      json['serviceData'].forEach((v) {
        _serviceData?.add(ShopServiceData.fromJson(v));
      });
    }
    if (json['employeeData'] != null) {
      _employeeData = [];
      json['employeeData'].forEach((v) {
        _employeeData?.add(ShopEmployeeData.fromJson(v));
      });
    }
  }

  num? _id;
  num? _ownerId;
  List<String>? _serviceId;
  List<String>? _packageId;
  List<String>? _employeeId;
  String? _name;
  String? _address;
  String? _image;
  String? _phoneNo;
  num? _isPopular;
  num? _isBest;
  String? _startTime;
  String? _endTime;
  num? _serviceType;
  num? _status;
  String? _imageUri;
  String? _avgRating;
  List<PackageData>? _packageData;
  List<ShopServiceData>? _serviceData;
  List<ShopEmployeeData>? _employeeData;

  ShopData copyWith({
    num? id,
    num? ownerId,
    List<String>? serviceId,
    List<String>? packageId,
    List<String>? employeeId,
    String? name,
    String? address,
    String? image,
    String? phoneNo,
    num? isPopular,
    num? isBest,
    String? startTime,
    String? endTime,
    num? serviceType,
    num? status,
    String? imageUri,
    String? avgRating,
    List<PackageData>? packageData,
    List<ShopServiceData>? serviceData,
    List<ShopEmployeeData>? employeeData,
  }) =>
      ShopData(
        id: id ?? _id,
        ownerId: ownerId ?? _ownerId,
        serviceId: serviceId ?? _serviceId,
        packageId: packageId ?? _packageId,
        employeeId: employeeId ?? _employeeId,
        name: name ?? _name,
        address: address ?? _address,
        image: image ?? _image,
        phoneNo: phoneNo ?? _phoneNo,
        isPopular: isPopular ?? _isPopular,
        isBest: isBest ?? _isBest,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        serviceType: serviceType ?? _serviceType,
        status: status ?? _status,
        imageUri: imageUri ?? _imageUri,
        avgRating: avgRating ?? _avgRating,
        packageData: packageData ?? _packageData,
        shopServiceData: serviceData ?? _serviceData,
        employeeData: employeeData ?? _employeeData,
      );

  num? get id => _id;

  num? get ownerId => _ownerId;

  List<String>? get serviceId => _serviceId;

  List<String>? get packageId => _packageId;

  List<String>? get employeeId => _employeeId;

  String? get name => _name;

  String? get address => _address;

  String? get image => _image;

  String? get phoneNo => _phoneNo;

  num? get isPopular => _isPopular;

  num? get isBest => _isBest;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  num? get serviceType => _serviceType;

  num? get status => _status;

  String? get imageUri => _imageUri;

  String? get avgRating => _avgRating;

  List<PackageData>? get packageData => _packageData;

  List<ShopServiceData>? get serviceData => _serviceData;

  List<ShopEmployeeData>? get employeeData => _employeeData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['owner_id'] = _ownerId;
    map['service_id'] = _serviceId;
    map['package_id'] = _packageId;
    map['employee_id'] = _employeeId;
    map['name'] = _name;
    map['address'] = _address;
    map['image'] = _image;
    map['phone_no'] = _phoneNo;
    map['is_popular'] = _isPopular;
    map['is_best'] = _isBest;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['service_type'] = _serviceType;
    map['status'] = _status;
    map['imageUri'] = _imageUri;
    map['avg_rating'] = _avgRating.toString();
    if (_packageData != null) {
      map['packageData'] = _packageData?.map((v) => v.toJson()).toList();
    }
    if (_serviceData != null) {
      map['serviceData'] = _serviceData?.map((v) => v.toJson()).toList();
    }
    if (_employeeData != null) {
      map['employeeData'] = _employeeData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ShopServiceData {
  String? name;
  int? id;
  String? description;
  int? duration;
  int? price;
  String? currency;

  ShopServiceData(
      {this.name,
      this.id,
      this.description,
      this.duration,
      this.price,
      this.currency});

  ShopServiceData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    description = json['description'];
    duration = json['duration'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['description'] = description;
    data['duration'] = duration;
    data['price'] = price;
    data['currency'] = currency;
    return data;
  }
}

class ShopEmployeeData {
  String? name;
  int? id;
  String? email;
  int? online;
  String? image;
  String? imageUri;

  ShopEmployeeData(
      {this.name, this.id, this.email, this.online, this.image, this.imageUri});

  ShopEmployeeData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    online = json['online'];
    image = json['image'];
    imageUri = json['imageUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['email'] = email;
    data['online'] = online;
    data['image'] = image;
    data['imageUri'] = imageUri;
    return data;
  }
}
