class NotificationResponse {
  NotificationResponse({
    dynamic msg,
    List<NotificationData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  NotificationResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<NotificationData>? _data;
  bool? _success;

  NotificationResponse copyWith({
    dynamic msg,
    List<NotificationData>? data,
    bool? success,
  }) =>
      NotificationResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<NotificationData>? get data => _data;

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

class NotificationData {
  NotificationData({
    num? id,
    num? bookingId,
    dynamic userId,
    num? ownerId,
    dynamic empId,
    String? title,
    String? subTitle,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _bookingId = bookingId;
    _userId = userId;
    _ownerId = ownerId;
    _empId = empId;
    _title = title;
    _subTitle = subTitle;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  NotificationData.fromJson(dynamic json) {
    _id = json['id'];
    _bookingId = json['booking_id'];
    _userId = json['user_id'];
    _ownerId = json['owner_id'];
    _empId = json['emp_id'];
    _title = json['title'];
    _subTitle = json['sub_title'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _bookingId;
  dynamic _userId;
  num? _ownerId;
  dynamic _empId;
  String? _title;
  String? _subTitle;
  String? _createdAt;
  String? _updatedAt;

  NotificationData copyWith({
    num? id,
    num? bookingId,
    dynamic userId,
    num? ownerId,
    dynamic empId,
    String? title,
    String? subTitle,
    String? createdAt,
    String? updatedAt,
  }) =>
      NotificationData(
        id: id ?? _id,
        bookingId: bookingId ?? _bookingId,
        userId: userId ?? _userId,
        ownerId: ownerId ?? _ownerId,
        empId: empId ?? _empId,
        title: title ?? _title,
        subTitle: subTitle ?? _subTitle,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get bookingId => _bookingId;

  dynamic get userId => _userId;

  num? get ownerId => _ownerId;

  dynamic get empId => _empId;

  String? get title => _title;

  String? get subTitle => _subTitle;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booking_id'] = _bookingId;
    map['user_id'] = _userId;
    map['owner_id'] = _ownerId;
    map['emp_id'] = _empId;
    map['title'] = _title;
    map['sub_title'] = _subTitle;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
