class SingleEmployeeProfileResponse {
  SingleEmployeeProfileResponse({
    dynamic msg,
    EmployeeProfileData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  SingleEmployeeProfileResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null
        ? EmployeeProfileData.fromJson(json['data'])
        : null;
    _success = json['success'];
  }

  dynamic _msg;
  EmployeeProfileData? _data;
  bool? _success;

  SingleEmployeeProfileResponse copyWith({
    dynamic msg,
    EmployeeProfileData? data,
    bool? success,
  }) =>
      SingleEmployeeProfileResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  EmployeeProfileData? get data => _data;

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

class EmployeeProfileData {
  EmployeeProfileData({
    num? id,
    num? ownerId,
    String? name,
    String? email,
    String? experience,
    String? idNo,
    String? image,
    dynamic deviceToken,
    String? phoneNo,
    dynamic otp,
    String? startTime,
    String? endTime,
    num? status,
    num? noti,
    num? online,
    String? currency,
    String? imageUri,
    num? avgRating,
    List<Booking>? booking,
    List<Reviews>? reviews,
  }) {
    _id = id;
    _ownerId = ownerId;
    _name = name;
    _email = email;
    _experience = experience;
    _idNo = idNo;
    _image = image;
    _deviceToken = deviceToken;
    _phoneNo = phoneNo;
    _otp = otp;
    _startTime = startTime;
    _endTime = endTime;
    _status = status;
    _noti = noti;
    _online = online;
    _currency = currency;
    _imageUri = imageUri;
    _avgRating = avgRating;
    _booking = booking;
    _reviews = reviews;
  }

  EmployeeProfileData.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['owner_id'];
    _name = json['name'];
    _email = json['email'];
    _experience = json['experience'];
    _idNo = json['id_no'];
    _image = json['image'];
    _deviceToken = json['device_token'];
    _phoneNo = json['phone_no'];
    _otp = json['otp'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _status = json['status'];
    _noti = json['noti'];
    _online = json['online'];
    _currency = json['currency'];
    _imageUri = json['imageUri'];
    _avgRating = json['avgRating'].runtimeType == String
        ? num.parse(json['avgRating'])
        : json['avgRating'];
    if (json['booking'] != null) {
      _booking = [];
      json['booking'].forEach((v) {
        _booking?.add(Booking.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      _reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        _reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  num? _id;
  num? _ownerId;
  String? _name;
  String? _email;
  String? _experience;
  String? _idNo;
  String? _image;
  dynamic _deviceToken;
  String? _phoneNo;
  dynamic _otp;
  String? _startTime;
  String? _endTime;
  num? _status;
  num? _noti;
  num? _online;
  String? _currency;
  String? _imageUri;
  num? _avgRating;
  List<Booking>? _booking;
  List<Reviews>? _reviews;

  EmployeeProfileData copyWith({
    num? id,
    num? ownerId,
    String? name,
    String? email,
    String? experience,
    String? idNo,
    String? image,
    dynamic deviceToken,
    String? phoneNo,
    dynamic otp,
    String? startTime,
    String? endTime,
    num? status,
    num? noti,
    num? online,
    String? currency,
    String? imageUri,
    num? avgRating,
    List<Booking>? booking,
    List<Reviews>? reviews,
  }) =>
      EmployeeProfileData(
        id: id ?? _id,
        ownerId: ownerId ?? _ownerId,
        name: name ?? _name,
        email: email ?? _email,
        experience: experience ?? _experience,
        idNo: idNo ?? _idNo,
        image: image ?? _image,
        deviceToken: deviceToken ?? _deviceToken,
        phoneNo: phoneNo ?? _phoneNo,
        otp: otp ?? _otp,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        status: status ?? _status,
        noti: noti ?? _noti,
        online: online ?? _online,
        currency: currency ?? _currency,
        imageUri: imageUri ?? _imageUri,
        avgRating: avgRating ?? _avgRating,
        booking: booking ?? _booking,
        reviews: reviews ?? _reviews,
      );

  num? get id => _id;

  num? get ownerId => _ownerId;

  String? get name => _name;

  String? get email => _email;

  String? get experience => _experience;

  String? get idNo => _idNo;

  String? get image => _image;

  dynamic get deviceToken => _deviceToken;

  String? get phoneNo => _phoneNo;

  dynamic get otp => _otp;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  num? get status => _status;

  num? get noti => _noti;

  num? get online => _online;

  String? get currency => _currency;

  String? get imageUri => _imageUri;

  num? get avgRating => _avgRating;

  List<Booking>? get booking => _booking;

  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['owner_id'] = _ownerId;
    map['name'] = _name;
    map['email'] = _email;
    map['experience'] = _experience;
    map['id_no'] = _idNo;
    map['image'] = _image;
    map['device_token'] = _deviceToken;
    map['phone_no'] = _phoneNo;
    map['otp'] = _otp;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['status'] = _status;
    map['noti'] = _noti;
    map['online'] = _online;
    map['currency'] = _currency;
    map['imageUri'] = _imageUri;
    map['avgRating'] = _avgRating;
    if (_booking != null) {
      map['booking'] = _booking?.map((v) => v.toJson()).toList();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Booking {
  Booking({
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
    String? currency,
    User? user,
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
    _currency = currency;
    _user = user;
  }

  Booking.fromJson(dynamic json) {
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
    _currency = json['currency'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  String? _currency;
  User? _user;

  Booking copyWith({
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
    String? currency,
    User? user,
  }) =>
      Booking(
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
        currency: currency ?? _currency,
        user: user ?? _user,
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

  String? get currency => _currency;

  User? get user => _user;

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
    map['currency'] = _currency;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    num? id,
    String? name,
    String? email,
    String? phoneNo,
    String? image,
    dynamic address,
    dynamic deviceToken,
    num? status,
    dynamic otp,
    num? noti,
    num? verified,
    String? imageUri,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phoneNo = phoneNo;
    _image = image;
    _address = address;
    _deviceToken = deviceToken;
    _status = status;
    _otp = otp;
    _noti = noti;
    _verified = verified;
    _imageUri = imageUri;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phoneNo = json['phone_no'];
    _image = json['image'];
    _address = json['address'];
    _deviceToken = json['device_token'];
    _status = json['status'];
    _otp = json['otp'];
    _noti = json['noti'];
    _verified = json['verified'];
    _imageUri = json['imageUri'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _phoneNo;
  String? _image;
  dynamic _address;
  dynamic _deviceToken;
  num? _status;
  dynamic _otp;
  num? _noti;
  num? _verified;
  String? _imageUri;

  User copyWith({
    num? id,
    String? name,
    String? email,
    String? phoneNo,
    String? image,
    dynamic address,
    dynamic deviceToken,
    num? status,
    dynamic otp,
    num? noti,
    num? verified,
    String? imageUri,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phoneNo: phoneNo ?? _phoneNo,
        image: image ?? _image,
        address: address ?? _address,
        deviceToken: deviceToken ?? _deviceToken,
        status: status ?? _status,
        otp: otp ?? _otp,
        noti: noti ?? _noti,
        verified: verified ?? _verified,
        imageUri: imageUri ?? _imageUri,
      );

  num? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phoneNo => _phoneNo;

  String? get image => _image;

  dynamic get address => _address;

  dynamic get deviceToken => _deviceToken;

  num? get status => _status;

  dynamic get otp => _otp;

  num? get noti => _noti;

  num? get verified => _verified;

  String? get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone_no'] = _phoneNo;
    map['image'] = _image;
    map['address'] = _address;
    map['device_token'] = _deviceToken;
    map['status'] = _status;
    map['otp'] = _otp;
    map['noti'] = _noti;
    map['verified'] = _verified;
    map['imageUri'] = _imageUri;
    return map;
  }
}

class Reviews {
  int? _id;
  int? _userId;
  int? _employeeId;
  int? _shopId;
  int? _bookingId;
  int? _star;
  String? _cmt;
  String? _createdAt;
  String? _updatedAt;
  ReviewUser? _user;

  Reviews(
      {int? id,
      int? userId,
      int? employeeId,
      int? shopId,
      int? bookingId,
      int? star,
      String? cmt,
      String? createdAt,
      String? updatedAt,
      ReviewUser? user}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (employeeId != null) {
      _employeeId = employeeId;
    }
    if (shopId != null) {
      _shopId = shopId;
    }
    if (bookingId != null) {
      _bookingId = bookingId;
    }
    if (star != null) {
      _star = star;
    }
    if (cmt != null) {
      _cmt = cmt;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (user != null) {
      _user = user;
    }
  }

  // ignore: unnecessary_getters_setters
  int? get id => _id;

  set id(int? id) => _id = id;

// ignore: unnecessary_getters_setters
  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

// ignore: unnecessary_getters_setters
  int? get employeeId => _employeeId;

  set employeeId(int? employeeId) => _employeeId = employeeId;

// ignore: unnecessary_getters_setters
  int? get shopId => _shopId;

  set shopId(int? shopId) => _shopId = shopId;

// ignore: unnecessary_getters_setters
  int? get bookingId => _bookingId;

  set bookingId(int? bookingId) => _bookingId = bookingId;

// ignore: unnecessary_getters_setters
  int? get star => _star;

  set star(int? star) => _star = star;

// ignore: unnecessary_getters_setters
  String? get cmt => _cmt;

  set cmt(String? cmt) => _cmt = cmt;

// ignore: unnecessary_getters_setters
  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

// ignore: unnecessary_getters_setters
  String? get updatedAt => _updatedAt;

  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

// ignore: unnecessary_getters_setters
  ReviewUser? get user => _user;

  set user(ReviewUser? user) => _user = user;

  Reviews.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _employeeId = json['employee_id'];
    _shopId = json['shop_id'];
    _bookingId = json['booking_id'];
    _star = json['star'];
    _cmt = json['cmt'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? ReviewUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['employee_id'] = _employeeId;
    data['shop_id'] = _shopId;
    data['booking_id'] = _bookingId;
    data['star'] = _star;
    data['cmt'] = _cmt;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    return data;
  }
}

class ReviewUser {
  String? _name;
  int? _id;
  String? _image;
  String? _imageUri;

  ReviewUser({String? name, int? id, String? image, String? imageUri}) {
    if (name != null) {
      _name = name;
    }
    if (id != null) {
      _id = id;
    }
    if (image != null) {
      _image = image;
    }
    if (imageUri != null) {
      _imageUri = imageUri;
    }
  }

// ignore: unnecessary_getters_setters
  String? get name => _name;

  set name(String? name) => _name = name;

// ignore: unnecessary_getters_setters
  int? get id => _id;

  set id(int? id) => _id = id;

// ignore: unnecessary_getters_setters
  String? get image => _image;

  set image(String? image) => _image = image;

// ignore: unnecessary_getters_setters
  String? get imageUri => _imageUri;

  set imageUri(String? imageUri) => _imageUri = imageUri;

  ReviewUser.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];
    _image = json['image'];
    _imageUri = json['imageUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['id'] = _id;
    data['image'] = _image;
    data['imageUri'] = _imageUri;
    return data;
  }
}
