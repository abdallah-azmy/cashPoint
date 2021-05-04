// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyProfileDataForStoreModel welcomeFromJson(String str) => MyProfileDataForStoreModel.fromJson(json.decode(str));

String welcomeToJson(MyProfileDataForStoreModel data) => json.encode(data.toJson());

class MyProfileDataForStoreModel {
  MyProfileDataForStoreModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory MyProfileDataForStoreModel.fromJson(Map<String, dynamic> json) => MyProfileDataForStoreModel(
    mainCode: json["mainCode"] == null ? null : json["mainCode"],
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode == null ? null : mainCode,
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.phone,
    this.logo,
    this.membershipNum,
    this.totalSales,
    this.totalCommissions,
    this.currentCommissions,
    this.paidCommissions,
    this.coupon,
    this.lastLoginAt,
    this.maxCommission,
    this.isPaid,
    this.onlinePayment,
  });

  int id;
  String name;
  String phone;
  String logo;
  int membershipNum;
  String totalSales;
  String totalCommissions;
  String currentCommissions;
  String paidCommissions;
  String coupon;
  String lastLoginAt;
  String maxCommission;
  int isPaid;
  int onlinePayment;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    logo: json["logo"] == null ? null : json["logo"],
    membershipNum: json["membership_num"] == null ? null : json["membership_num"],
    totalSales: json["total_sales"] == null ? null : json["total_sales"],
    totalCommissions: json["total_commissions"] == null ? null : json["total_commissions"],
    currentCommissions: json["current_commissions"] == null ? null : json["current_commissions"],
    paidCommissions: json["paid_commissions"] == null ? null : json["paid_commissions"],
    coupon: json["coupon"] == null ? null : json["coupon"],
    lastLoginAt: json["last_login_at"] == null ? null : json["last_login_at"],
    maxCommission: json["max_commission"] == null ? null : json["max_commission"],
    isPaid: json["is_paid"] == null ? null : json["is_paid"],
    onlinePayment: json["online_payment"] == null ? null : json["online_payment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "logo": logo == null ? null : logo,
    "membership_num": membershipNum == null ? null : membershipNum,
    "total_sales": totalSales == null ? null : totalSales,
    "total_commissions": totalCommissions == null ? null : totalCommissions,
    "current_commissions": currentCommissions == null ? null : currentCommissions,
    "paid_commissions": paidCommissions == null ? null : paidCommissions,
    "coupon": coupon == null ? null : coupon,
    "last_login_at": lastLoginAt == null ? null : lastLoginAt,
    "max_commission": maxCommission == null ? null : maxCommission,
    "max_commission": maxCommission == null ? null : maxCommission,
    "is_paid": isPaid == null ? null : isPaid,
    "online_payment": onlinePayment == null ? null : onlinePayment,
  };
}

class Error {
  Error({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
  };
}