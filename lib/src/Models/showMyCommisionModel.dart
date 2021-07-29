// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ShowMyCommisionModel welcomeFromJson(String str) => ShowMyCommisionModel.fromJson(json.decode(str));

String welcomeToJson(ShowMyCommisionModel data) => json.encode(data.toJson());

class ShowMyCommisionModel {
  ShowMyCommisionModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory ShowMyCommisionModel.fromJson(Map<String, dynamic> json) => ShowMyCommisionModel(
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
    this.commissionIsPaid,
    this.orderNumber,
    this.status,
    this.ratedOrNot,
    this.rate,
    this.isRefundRequest,
    this.refundRequest,
    this.pointIsAvailable,
    this.cashierId,
    this.cashierName,
    this.cashierPhone,
    this.createdAt,
  });

  int id;
  int userId;
  String userName;
  String userPhone;
  int storeId;
  String storeName;
  String storePhone;
  int cash;
  int point;
  String commission;
  int commissionIsPaid;
  int orderNumber;
  int status;
  int ratedOrNot;
  dynamic rate;
  bool isRefundRequest;
  int refundRequest;
  int pointIsAvailable;
  dynamic cashierId;
  dynamic cashierName;
  dynamic cashierPhone;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    storeName: json["store_name"] == null ? null : json["store_name"],
    storePhone: json["store_phone"] == null ? null : json["store_phone"],
    cash: json["cash"] == null ? null : json["cash"],
    point: json["point"] == null ? null : json["point"],
    commission: json["commission"] == null ? null : "${json["commission"]}",
    commissionIsPaid: json["commission_is_paid"] == null ? null : json["commission_is_paid"],
    orderNumber: json["order_number"] == null ? null : json["order_number"],
    status: json["status"] == null ? null : json["status"],
    ratedOrNot: json["rated_or_not"] == null ? null : json["rated_or_not"],
    rate: json["rate"],
    isRefundRequest: json["is_refund_request"] == null ? null : json["is_refund_request"],
    refundRequest: json["Refund_request"] == null ? null : json["Refund_request"],
    pointIsAvailable: json["pointIsAvailable"] == null ? null : json["pointIsAvailable"],
    cashierId: json["cashier_id"],
    cashierName: json["cashier_name"],
    cashierPhone: json["cashier_phone"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
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
    "commission_is_paid": commissionIsPaid == null ? null : commissionIsPaid,
    "order_number": orderNumber == null ? null : orderNumber,
    "status": status == null ? null : status,
    "rated_or_not": ratedOrNot == null ? null : ratedOrNot,
    "rate": rate,
    "is_refund_request": isRefundRequest == null ? null : isRefundRequest,
    "Refund_request": refundRequest == null ? null : refundRequest,
    "pointIsAvailable": pointIsAvailable == null ? null : pointIsAvailable,
    "cashier_id": cashierId,
    "cashier_name": cashierName,
    "cashier_phone": cashierPhone,
    "created_at": createdAt == null ? null : createdAt,
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