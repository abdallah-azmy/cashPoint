// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PayOffCommissionModel welcomeFromJson(String str) => PayOffCommissionModel.fromJson(json.decode(str));

String welcomeToJson(PayOffCommissionModel data) => json.encode(data.toJson());

class PayOffCommissionModel {
  PayOffCommissionModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory PayOffCommissionModel.fromJson(Map<String, dynamic> json) => PayOffCommissionModel(
    mainCode: json["mainCode"] == null ? null : json["mainCode"],
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode == null ? null : mainCode,
    "code": code == null ? null : code,
    "data": data == null ? null : data.toJson(),
    "error": error,
  };
}

class Data {
  Data({
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
    this.paymentUrl,
  });

  int id;
  int userId;
  String userName;
  String userPhone;
  String total;
  String image;
  dynamic invoice;
  int status;
  dynamic coupon;
  dynamic couponId;
  DateTime createdAt;
  dynamic paymentUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    total: json["total"] == null ? null : "${json["total"]}",
    image: json["image"] == null ? null : json["image"],
    invoice: json["invoice"],
    status: json["status"] == null ? null : json["status"],
    coupon: json["coupon"],
    couponId: json["coupon_id"],
    paymentUrl: json["PaymentURL"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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
    "coupon": coupon,
    "coupon_id": couponId,
    "PaymentURL": paymentUrl,
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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