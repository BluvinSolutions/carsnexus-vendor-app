class LoginResponse {
  LoginResponse({
    String? msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  LoginResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  Data? _data;
  bool? _success;

  LoginResponse copyWith({
    String? msg,
    Data? data,
    bool? success,
  }) =>
      LoginResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  Data? get data => _data;

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

class Data {
  Data({
    num? id,
    String? name,
    String? email,
    String? phoneNo,
    String? image,
    num? verified,
    num? status,
    num? noti,
    num? autoAssign,
    num? empDeclineReq,
    dynamic deviceToken,
    String? token,
    String? imageUri,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phoneNo = phoneNo;
    _image = image;
    _verified = verified;
    _status = status;
    _noti = noti;
    _autoAssign = autoAssign;
    _empDeclineReq = empDeclineReq;
    _deviceToken = deviceToken;
    _token = token;
    _imageUri = imageUri;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phoneNo = json['phone_no'];
    _image = json['image'];
    _verified = json['verified'];
    _status = json['status'];
    _noti = json['noti'];
    _autoAssign = json['auto_assign'];
    _empDeclineReq = json['emp_decline_req'];
    _deviceToken = json['device_token'];
    _token = json['token'];
    _imageUri = json['imageUri'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _phoneNo;
  String? _image;
  num? _verified;
  num? _status;
  num? _noti;
  num? _autoAssign;
  num? _empDeclineReq;
  dynamic _deviceToken;
  String? _token;
  String? _imageUri;

  Data copyWith({
    num? id,
    String? name,
    String? email,
    String? phoneNo,
    String? image,
    num? verified,
    num? status,
    num? noti,
    num? autoAssign,
    num? empDeclineReq,
    dynamic deviceToken,
    String? token,
    String? imageUri,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phoneNo: phoneNo ?? _phoneNo,
        image: image ?? _image,
        verified: verified ?? _verified,
        status: status ?? _status,
        noti: noti ?? _noti,
        autoAssign: autoAssign ?? _autoAssign,
        empDeclineReq: empDeclineReq ?? _empDeclineReq,
        deviceToken: deviceToken ?? _deviceToken,
        token: token ?? _token,
        imageUri: imageUri ?? _imageUri,
      );

  num? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phoneNo => _phoneNo;

  String? get image => _image;

  num? get verified => _verified;

  num? get status => _status;

  num? get noti => _noti;

  num? get autoAssign => _autoAssign;

  num? get empDeclineReq => _empDeclineReq;

  dynamic get deviceToken => _deviceToken;

  String? get token => _token;

  String? get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone_no'] = _phoneNo;
    map['image'] = _image;
    map['verified'] = _verified;
    map['status'] = _status;
    map['noti'] = _noti;
    map['auto_assign'] = _autoAssign;
    map['emp_decline_req'] = _empDeclineReq;
    map['device_token'] = _deviceToken;
    map['token'] = _token;
    map['imageUri'] = _imageUri;
    return map;
  }
}
