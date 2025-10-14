class RegisterResponse {
  RegisterResponse({
    String? msg,
    Data? data,
    bool? success,
    String? flow,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
    _flow = flow;
  }

  RegisterResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
    _flow = json['flow'];
  }

  String? _msg;
  Data? _data;
  bool? _success;
  String? _flow;

  RegisterResponse copyWith({
    String? msg,
    Data? data,
    bool? success,
    String? flow,
  }) =>
      RegisterResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
        flow: flow ?? _flow,
      );

  String? get msg => _msg;

  Data? get data => _data;

  bool? get success => _success;

  String? get flow => _flow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    map['flow'] = _flow;
    return map;
  }
}

class Data {
  Data({
    String? email,
    String? name,
    String? phoneNo,
    num? id,
    dynamic imageUri,
  }) {
    _email = email;
    _name = name;
    _phoneNo = phoneNo;
    _id = id;
    _imageUri = imageUri;
  }

  Data.fromJson(dynamic json) {
    _email = json['email'];
    _name = json['name'];
    _phoneNo = json['phone_no'];
    _id = json['id'];
    _imageUri = json['imageUri'];
  }

  String? _email;
  String? _name;
  String? _phoneNo;
  num? _id;
  dynamic _imageUri;

  Data copyWith({
    String? email,
    String? name,
    String? phoneNo,
    num? id,
    dynamic imageUri,
  }) =>
      Data(
        email: email ?? _email,
        name: name ?? _name,
        phoneNo: phoneNo ?? _phoneNo,
        id: id ?? _id,
        imageUri: imageUri ?? _imageUri,
      );

  String? get email => _email;

  String? get name => _name;

  String? get phoneNo => _phoneNo;

  num? get id => _id;

  dynamic get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['name'] = _name;
    map['phone_no'] = _phoneNo;
    map['id'] = _id;
    map['imageUri'] = _imageUri;
    return map;
  }
}
