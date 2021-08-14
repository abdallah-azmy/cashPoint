// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AllOrdersModel welcomeFromJson(String str) => AllOrdersModel.fromJson(json.decode(str));

String welcomeToJson(AllOrdersModel data) => json.encode(data.toJson());

class AllOrdersModel {
  AllOrdersModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
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
    this.storeId,
    this.storeName,
    this.storePhone,
    this.cash,
    this.point,
    this.commission,
    this.orderNumber,
    this.status,
    this.ratedOrNot,
    this.cashierId,
    this.cashierName,
    this.rate,
    this.cashierPhone,
    this.isRefundRequest,
    this.refundRequest,
    this.createdAt,
    this.pointIsAvailable,
  });

  int id;
  int userId;
  String userName;
  String userPhone;
  int storeId;
  String storeName;
  String storePhone;
  String cash;
  String point;
  String commission;
  int orderNumber;
  int status;
  int ratedOrNot;
  Rate rate;
  int cashierId;
  String cashierName;
  String cashierPhone;
  bool isRefundRequest;
  int refundRequest;
  String createdAt;
  int pointIsAvailable;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    storeName: json["store_name"] == null ? null : json["store_name"],
    storePhone: json["store_phone"] == null ? null : json["store_phone"],
    cash: json["cash"] == null ? null : "${json["cash"]}",
    point: json["point"] == null ? null : "${json["point"]}",
    commission: json["commission"] == null ? null : "${json["commission"]}",
    orderNumber: json["order_number"] == null ? null : json["order_number"],
    status: json["status"] == null ? null : json["status"],
    ratedOrNot: json["rated_or_not"] == null ? null : json["rated_or_not"],
    isRefundRequest: json["is_refund_request"] == null ? null : json["is_refund_request"],
    refundRequest: json["Refund_request"] == null ? null : json["Refund_request"],
    rate: json["rate"] == null ? null : Rate.fromJson(json["rate"]),
    cashierId: json["cashier_id"] == null ? null : json["cashier_id"],
    cashierName: json["cashier_name"] == null ? null : json["cashier_name"],
    cashierPhone: json["cashier_phone"] == null ? null : json["cashier_phone"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    pointIsAvailable: json["pointIsAvailable"] == null ? null : json["pointIsAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "user_name": userName == null ? null : userName,
    "user_phone": userPhone == null ? null : userPhone,
    "store_id": storeId == null ? null : storeId,
    "store_name": storeName == null ? null : storeName,
    "store_phone": storePhone == null ? null : storePhone,
    "cash": cash == null ? null : cash,
    "point": point == null ? null : point,
    "commission": commission == null ? null : commission,
    "order_number": orderNumber == null ? null : orderNumber,
    "status": status == null ? null : status,
    "rated_or_not": ratedOrNot == null ? null : ratedOrNot,
    "is_refund_request": isRefundRequest == null ? null : isRefundRequest,
    "Refund_request": refundRequest == null ? null : refundRequest,
    "cashier_id": cashierId == null ? null : cashierId,
    "rate": rate == null ? null : rate.toJson(),
    "cashier_name": cashierName == null ? null : cashierName,
    "cashier_phone": cashierPhone == null ? null : cashierPhone,
    "created_at": createdAt == null ? null : createdAt,
    "pointIsAvailable": pointIsAvailable == null ? null : pointIsAvailable,
  };
}


class Rate {
  Rate({
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

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
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