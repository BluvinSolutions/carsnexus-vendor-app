class SingleRequestResponse {
  SingleRequestResponse({
    dynamic msg,
    SingleRequestData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  SingleRequestResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data =
        json['data'] != null ? SingleRequestData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  SingleRequestData? _data;
  bool? _success;

  SingleRequestResponse copyWith({
    dynamic msg,
    SingleRequestData? data,
    bool? success,
  }) =>
      SingleRequestResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  SingleRequestData? get data => _data;

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

class SingleRequestData {
  SingleRequestData({
    num? id,
    String? bookingId,
    num? userId,
    num? shopId,
    num? ownerId,
    num? employeeId,
    num? adminPer,
    String? address,
    num? vehicleId,
    String? startTime,
    String? endTime,
    num? serviceType,
    num? amount,
    num? discount,
    num? paymentStatus,
    String? paymentToken,
    String? paymentMethod,
    num? status,
    List<String>? service,
    String? updatedAt,
    String? createdAt,
    List<ServiceData>? serviceData,
    String? currency,
    User? user,
    ServiceRequestModel? model,
    Shop? shop,
    Employee? employee,
  }) {
    _id = id;
    _bookingId = bookingId;
    _userId = userId;
    _shopId = shopId;
    _ownerId = ownerId;
    _employeeId = employeeId;
    _adminPer = adminPer;
    _address = address;
    _vehicleId = vehicleId;
    _startTime = startTime;
    _endTime = endTime;
    _serviceType = serviceType;
    _amount = amount;
    _discount = discount;
    _paymentStatus = paymentStatus;
    _paymentToken = paymentToken;
    _paymentMethod = paymentMethod;
    _status = status;
    _service = service;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _serviceData = serviceData;
    _currency = currency;
    _user = user;
    _model = model;
    _shop = shop;
    _employee = employee;
  }

  SingleRequestData.fromJson(dynamic json) {
    _id = json['id'];
    _bookingId = json['booking_id'];
    _userId = json['user_id'];
    _shopId = json['shop_id'];
    _ownerId = json['owner_id'];
    _employeeId = json['employee_id'];
    _adminPer = json['admin_per'];
    _address = json['address'];
    _vehicleId = json['vehicle_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _serviceType = json['service_type'];
    _amount = json['amount'];
    _discount = json['discount'];
    _paymentStatus = json['payment_status'];
    _paymentToken = json['payment_token'];
    _paymentMethod = json['payment_method'];
    _status = json['status'];
    _service = json['service'] != null ? json['service'].cast<String>() : [];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    if (json['serviceData'] != null) {
      _serviceData = [];
      json['serviceData'].forEach((v) {
        _serviceData?.add(ServiceData.fromJson(v));
      });
    }
    _currency = json['currency'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _model = json['model'] != null
        ? ServiceRequestModel.fromJson(json['model'])
        : null;
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
  }

  num? _id;
  String? _bookingId;
  num? _userId;
  num? _shopId;
  num? _ownerId;
  num? _employeeId;
  num? _adminPer;
  String? _address;
  num? _vehicleId;
  String? _startTime;
  String? _endTime;
  num? _serviceType;
  num? _amount;
  num? _discount;
  num? _paymentStatus;
  String? _paymentToken;
  String? _paymentMethod;
  num? _status;
  List<String>? _service;
  String? _updatedAt;
  String? _createdAt;
  List<ServiceData>? _serviceData;
  String? _currency;
  User? _user;
  ServiceRequestModel? _model;
  Shop? _shop;
  Employee? _employee;

  SingleRequestData copyWith({
    num? id,
    String? bookingId,
    num? userId,
    num? shopId,
    num? ownerId,
    num? employeeId,
    num? adminPer,
    String? address,
    num? vehicleId,
    String? startTime,
    String? endTime,
    num? serviceType,
    num? amount,
    num? discount,
    num? paymentStatus,
    String? paymentToken,
    String? paymentMethod,
    num? status,
    List<String>? service,
    String? updatedAt,
    String? createdAt,
    List<ServiceData>? serviceData,
    String? currency,
    User? user,
    ServiceRequestModel? model,
    Shop? shop,
    Employee? employee,
  }) =>
      SingleRequestData(
        id: id ?? _id,
        bookingId: bookingId ?? _bookingId,
        userId: userId ?? _userId,
        shopId: shopId ?? _shopId,
        ownerId: ownerId ?? _ownerId,
        employeeId: employeeId ?? _employeeId,
        adminPer: adminPer ?? _adminPer,
        address: address ?? _address,
        vehicleId: vehicleId ?? _vehicleId,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        serviceType: serviceType ?? _serviceType,
        amount: amount ?? _amount,
        discount: discount ?? _discount,
        paymentStatus: paymentStatus ?? _paymentStatus,
        paymentToken: paymentToken ?? _paymentToken,
        paymentMethod: paymentMethod ?? _paymentMethod,
        status: status ?? _status,
        service: service ?? _service,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        serviceData: serviceData ?? _serviceData,
        currency: currency ?? _currency,
        user: user ?? _user,
        model: model ?? _model,
        shop: shop ?? _shop,
        employee: employee ?? _employee,
      );

  num? get id => _id;

  String? get bookingId => _bookingId;

  num? get userId => _userId;

  num? get shopId => _shopId;

  num? get ownerId => _ownerId;

  num? get employeeId => _employeeId;

  num? get adminPer => _adminPer;

  String? get address => _address;

  num? get vehicleId => _vehicleId;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  num? get serviceType => _serviceType;

  num? get amount => _amount;

  num? get discount => _discount;

  num? get paymentStatus => _paymentStatus;

  String? get paymentToken => _paymentToken;

  String? get paymentMethod => _paymentMethod;

  num? get status => _status;

  List<String>? get service => _service;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  List<ServiceData>? get serviceData => _serviceData;

  String? get currency => _currency;

  User? get user => _user;

  ServiceRequestModel? get model => _model;

  Shop? get shop => _shop;

  Employee? get employee => _employee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booking_id'] = _bookingId;
    map['user_id'] = _userId;
    map['shop_id'] = _shopId;
    map['owner_id'] = _ownerId;
    map['employee_id'] = _employeeId;
    map['admin_per'] = _adminPer;
    map['address'] = _address;
    map['vehicle_id'] = _vehicleId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['service_type'] = _serviceType;
    map['amount'] = _amount;
    map['discount'] = _discount;
    map['payment_status'] = _paymentStatus;
    map['payment_token'] = _paymentToken;
    map['payment_method'] = _paymentMethod;
    map['status'] = _status;
    map['service'] = _service;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    if (_serviceData != null) {
      map['serviceData'] = _serviceData?.map((v) => v.toJson()).toList();
    }
    map['currency'] = _currency;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_model != null) {
      map['model'] = _model?.toJson();
    }
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }
    if (_employee != null) {
      map['employee'] = _employee!.toJson();
    }
    return map;
  }
}

class ServiceRequestModel {
  ServiceRequestModel({
    num? id,
    num? userId,
    num? modelId,
    String? regNumber,
    String? color,
    Model? model,
  }) {
    _id = id;
    _userId = userId;
    _modelId = modelId;
    _regNumber = regNumber;
    _color = color;
    _model = model;
  }

  ServiceRequestModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _modelId = json['model_id'];
    _regNumber = json['reg_number'];
    _color = json['color'];
    _model = json['model'] != null ? Model.fromJson(json['model']) : null;
  }

  num? _id;
  num? _userId;
  num? _modelId;
  String? _regNumber;
  String? _color;
  Model? _model;

  ServiceRequestModel copyWith({
    num? id,
    num? userId,
    num? modelId,
    String? regNumber,
    String? color,
    Model? model,
  }) =>
      ServiceRequestModel(
        id: id ?? _id,
        userId: userId ?? _userId,
        modelId: modelId ?? _modelId,
        regNumber: regNumber ?? _regNumber,
        color: color ?? _color,
        model: model ?? _model,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get modelId => _modelId;

  String? get regNumber => _regNumber;

  String? get color => _color;

  Model? get model => _model;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['model_id'] = _modelId;
    map['reg_number'] = _regNumber;
    map['color'] = _color;
    if (_model != null) {
      map['model'] = _model?.toJson();
    }
    return map;
  }
}

class Model {
  Model({
    num? id,
    num? brandId,
    String? name,
    Brand? brand,
  }) {
    _id = id;
    _brandId = brandId;
    _name = name;
    _brand = brand;
  }

  Model.fromJson(dynamic json) {
    _id = json['id'];
    _brandId = json['brand_id'];
    _name = json['name'];
    _brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
  }

  num? _id;
  num? _brandId;
  String? _name;
  Brand? _brand;

  Model copyWith({
    num? id,
    num? brandId,
    String? name,
    Brand? brand,
  }) =>
      Model(
        id: id ?? _id,
        brandId: brandId ?? _brandId,
        name: name ?? _name,
        brand: brand ?? _brand,
      );

  num? get id => _id;

  num? get brandId => _brandId;

  String? get name => _name;

  Brand? get brand => _brand;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['brand_id'] = _brandId;
    map['name'] = _name;
    if (_brand != null) {
      map['brand'] = _brand?.toJson();
    }
    return map;
  }
}

class Brand {
  Brand({
    num? id,
    String? name,
    String? icon,
    num? status,
    String? imageUri,
  }) {
    _id = id;
    _name = name;
    _icon = icon;
    _status = status;
    _imageUri = imageUri;
  }

  Brand.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _status = json['status'];
    _imageUri = json['imageUri'];
  }

  num? _id;
  String? _name;
  String? _icon;
  num? _status;
  String? _imageUri;

  Brand copyWith({
    num? id,
    String? name,
    String? icon,
    num? status,
    String? imageUri,
  }) =>
      Brand(
        id: id ?? _id,
        name: name ?? _name,
        icon: icon ?? _icon,
        status: status ?? _status,
        imageUri: imageUri ?? _imageUri,
      );

  num? get id => _id;

  String? get name => _name;

  String? get icon => _icon;

  num? get status => _status;

  String? get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['status'] = _status;
    map['imageUri'] = _imageUri;
    return map;
  }
}

class User {
  User({
    num? id,
    String? name,
    String? image,
    dynamic address,
    String? imageUri,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _address = address;
    _imageUri = imageUri;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _address = json['address'];
    _imageUri = json['imageUri'];
  }

  num? _id;
  String? _name;
  String? _image;
  dynamic _address;
  String? _imageUri;

  User copyWith({
    num? id,
    String? name,
    String? image,
    dynamic address,
    String? imageUri,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        address: address ?? _address,
        imageUri: imageUri ?? _imageUri,
      );

  num? get id => _id;

  String? get name => _name;

  String? get image => _image;

  dynamic get address => _address;

  String? get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['address'] = _address;
    map['imageUri'] = _imageUri;
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

class Shop {
  int? id;
  int? ownerId;
  List<String>? serviceId;
  List<String>? packageId;
  List<String>? employeeId;
  String? name;
  String? address;
  String? image;
  String? phoneNo;
  int? isPopular;
  int? isBest;
  String? startTime;
  String? endTime;
  int? serviceType;
  int? status;
  String? imageUri;
  String? avgRating;

  Shop(
      {this.id,
      this.ownerId,
      this.serviceId,
      this.packageId,
      this.employeeId,
      this.name,
      this.address,
      this.image,
      this.phoneNo,
      this.isPopular,
      this.isBest,
      this.startTime,
      this.endTime,
      this.serviceType,
      this.status,
      this.imageUri,
      this.avgRating});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    serviceId = json['service_id'].cast<String>();
    packageId = json['package_id'].cast<String>();
    employeeId = json['employee_id'].cast<String>();
    name = json['name'];
    address = json['address'];
    image = json['image'];
    phoneNo = json['phone_no'];
    isPopular = json['is_popular'];
    isBest = json['is_best'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    serviceType = json['service_type'];
    status = json['status'];
    imageUri = json['imageUri'];
    avgRating = json['avg_rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['service_id'] = serviceId;
    data['package_id'] = packageId;
    data['employee_id'] = employeeId;
    data['name'] = name;
    data['address'] = address;
    data['image'] = image;
    data['phone_no'] = phoneNo;
    data['is_popular'] = isPopular;
    data['is_best'] = isBest;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['service_type'] = serviceType;
    data['status'] = status;
    data['imageUri'] = imageUri;
    data['avg_rating'] = avgRating;
    return data;
  }
}

class Employee {
  int? id;
  int? ownerId;
  String? name;
  String? email;
  String? experience;
  String? idNo;
  String? image;
  String? deviceToken;
  String? phoneNo;
  dynamic otp;
  String? startTime;
  String? endTime;
  int? status;
  int? noti;
  int? online;
  String? imageUri;

  Employee(
      {this.id,
      this.ownerId,
      this.name,
      this.email,
      this.experience,
      this.idNo,
      this.image,
      this.deviceToken,
      this.phoneNo,
      this.otp,
      this.startTime,
      this.endTime,
      this.status,
      this.noti,
      this.online,
      this.imageUri});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    name = json['name'];
    email = json['email'];
    experience = json['experience'];
    idNo = json['id_no'];
    image = json['image'];
    deviceToken = json['device_token'];
    phoneNo = json['phone_no'];
    otp = json['otp'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    noti = json['noti'];
    online = json['online'];
    imageUri = json['imageUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['name'] = name;
    data['email'] = email;
    data['experience'] = experience;
    data['id_no'] = idNo;
    data['image'] = image;
    data['device_token'] = deviceToken;
    data['phone_no'] = phoneNo;
    data['otp'] = otp;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['noti'] = noti;
    data['online'] = online;
    data['imageUri'] = imageUri;
    return data;
  }
}
