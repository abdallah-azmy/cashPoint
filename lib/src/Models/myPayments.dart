// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyPaymentsModel welcomeFromJson(String str) => MyPaymentsModel.fromJson(json.decode(str));

String welcomeToJson(MyPaymentsModel data) => json.encode(data.toJson());

class MyPaymentsModel {
  MyPaymentsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory MyPaymentsModel.fromJson(Map<String, dynamic> json) => MyPaymentsModel(
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
    this.userId,
    this.userName,
    this.userPhone,
    this.total,
    this.image,
    this.invoice,
    this.status,
    this.coupon,
    this.couponId,
    this.createdAt,
  });

  int id;
  int userId;
  String userName;
  String userPhone;
  String total;
  String image;
  dynamic invoice;
  int status;
  String coupon;
  dynamic couponId;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    total: json["total"] == null ? null : "${json["total"]}",
    image: json["image"] == null ? null : json["image"],
    invoice: json["invoice"],
    status: json["status"] == null ? null : json["status"],
    coupon: json["coupon"] == null ? null : json["coupon"],
    couponId: json["coupon_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "user_name": userName == null ? null : userName,
    "user_phone": userPhone == null ? null : userPhone,
    "total": total == null ? null : total,
    "image": image == null ? null : image,
    "invoice": invoice,
    "status": status == null ? null : status,
    "coupon": coupon == null ? null : coupon,
    "coupon_id": couponId,
    "created_at": createdAt == null ? null :createdAt,
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