// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RateOrderModel welcomeFromJson(String str) => RateOrderModel.fromJson(json.decode(str));

String welcomeToJson(RateOrderModel data) => json.encode(data.toJson());

class RateOrderModel {
  RateOrderModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory RateOrderModel.fromJson(Map<String, dynamic> json) => RateOrderModel(
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
    this.transactionId,
    this.userId,
    this.userName,
    this.userPhone,
    this.storeId,
    this.storeName,
    this.storePhone,
    this.rate,
    this.description,
    this.createdAt,
  });

  int id;
  int transactionId;
  int userId;
  String userName;
  String userPhone;
  int storeId;
  String storeName;
  String storePhone;
  int rate;
  String description;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    storeName: json["store_name"] == null ? null : json["store_name"],
    storePhone: json["store_phone"] == null ? null : json["store_phone"],
    rate: json["rate"] == null ? null : json["rate"],
    description: json["description"] == null ? null : json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transaction_id": transactionId == null ? null : transactionId,
    "user_id": userId == null ? null : userId,
    "user_name": userName == null ? null : userName,
    "user_phone": userPhone == null ? null : userPhone,
    "store_id": storeId == null ? null : storeId,
    "store_name": storeName == null ? null : storeName,
    "store_phone": storePhone == null ? null : storePhone,
    "rate": rate == null ? null : rate,
    "description": description == null ? null : description,
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