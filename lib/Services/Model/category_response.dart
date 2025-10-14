class CategoryResponse {
  CategoryResponse({
    dynamic msg,
    List<CategoryData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  CategoryResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  dynamic _msg;
  List<CategoryData>? _data;
  bool? _success;

  CategoryResponse copyWith({
    dynamic msg,
    List<CategoryData>? data,
    bool? success,
  }) =>
      CategoryResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

  List<CategoryData>? get data => _data;

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

class CategoryData {
  CategoryData({
    num? id,
    String? name,
    String? icon,
    num? isTrending,
    num? status,
    String? imageUri,
  }) {
    _id = id;
    _name = name;
    _icon = icon;
    _isTrending = isTrending;
    _status = status;
    _imageUri = imageUri;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _isTrending = json['is_trending'];
    _status = json['status'];
    _imageUri = json['imageUri'];
  }

  num? _id;
  String? _name;
  String? _icon;
  num? _isTrending;
  num? _status;
  String? _imageUri;

  CategoryData copyWith({
    num? id,
    String? name,
    String? icon,
    num? isTrending,
    num? status,
    String? imageUri,
  }) =>
      CategoryData(
        id: id ?? _id,
        name: name ?? _name,
        icon: icon ?? _icon,
        isTrending: isTrending ?? _isTrending,
        status: status ?? _status,
        imageUri: imageUri ?? _imageUri,
      );

  num? get id => _id;

  String? get name => _name;

  String? get icon => _icon;

  num? get isTrending => _isTrending;

  num? get status => _status;

  String? get imageUri => _imageUri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['is_trending'] = _isTrending;
    map['status'] = _status;
    map['imageUri'] = _imageUri;
    return map;
  }
}
