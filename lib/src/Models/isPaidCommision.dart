// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

IsPaidCommissionModel welcomeFromJson(String str) => IsPaidCommissionModel.fromJson(json.decode(str));

String welcomeToJson(IsPaidCommissionModel data) => json.encode(data.toJson());

class IsPaidCommissionModel {
  IsPaidCommissionModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory IsPaidCommissionModel.fromJson(Map<String, dynamic> json) => IsPaidCommissionModel(
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
    this.isPaid,
    this.currentCommissions,
    this.paidCommissions,
  });

  int isPaid;
  String currentCommissions;
  int paidCommissions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isPaid: json["is_paid"] == null ? null : json["is_paid"],
    currentCommissions: json["current_commissions"] == null ? null : "${json["current_commissions"]}",
    paidCommissions: json["paid_commissions"] == null ? null : json["paid_commissions"],
  );

  Map<String, dynamic> toJson() => {
    "is_paid": isPaid == null ? null : isPaid,
    "current_commissions": currentCommissions == null ? null : currentCommissions,
    "paid_commissions": paidCommissions == null ? null : paidCommissions,
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