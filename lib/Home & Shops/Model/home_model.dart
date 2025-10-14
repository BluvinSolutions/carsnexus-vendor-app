class HomeModel {
  HomeModel({
    dynamic msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  HomeModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  dynamic _msg;
  Data? _data;
  bool? _success;

  HomeModel copyWith({
    dynamic msg,
    Data? data,
    bool? success,
  }) =>
      HomeModel(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  dynamic get msg => _msg;

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
    num? data,
    num? income,
    num? homeData,
    num? homeIncome,
    num? shopData,
    num? shopIncome,
    String? currency,
  }) {
    _data = data;
    _income = income;
    _homeData = homeData;
    _homeIncome = homeIncome;
    _shopData = shopData;
    _shopIncome = shopIncome;
    _currency = currency;
  }

  Data.fromJson(dynamic json) {
    _data = json['data'];
    _income = json['income'];
    _homeData = json['home_data'];
    _homeIncome = json['home_income'];
    _shopData = json['shop_data'];
    _shopIncome = json['shop_income'];
    _currency = json['currency'];
  }

  num? _data;
  num? _income;
  num? _homeData;
  num? _homeIncome;
  num? _shopData;
  num? _shopIncome;
  String? _currency;

  Data copyWith({
    num? data,
    num? income,
    num? homeData,
    num? homeIncome,
    num? shopData,
    num? shopIncome,
    String? currency,
  }) =>
      Data(
        data: data ?? _data,
        income: income ?? _income,
        homeData: homeData ?? _homeData,
        homeIncome: homeIncome ?? _homeIncome,
        shopData: shopData ?? _shopData,
        shopIncome: shopIncome ?? _shopIncome,
        currency: currency ?? _currency,
      );

  num? get data => _data;

  num? get income => _income;

  num? get homeData => _homeData;

  num? get homeIncome => _homeIncome;

  num? get shopData => _shopData;

  num? get shopIncome => _shopIncome;

  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['income'] = _income;
    map['home_data'] = _homeData;
    map['home_income'] = _homeIncome;
    map['shop_data'] = _shopData;
    map['shop_income'] = _shopIncome;
    map['currency'] = _currency;
    return map;
  }
}
