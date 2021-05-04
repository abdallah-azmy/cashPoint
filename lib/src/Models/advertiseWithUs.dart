// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AdvertiseWithUsModel welcomeFromJson(String str) => AdvertiseWithUsModel.fromJson(json.decode(str));

String welcomeToJson(AdvertiseWithUsModel data) => json.encode(data.toJson());

class AdvertiseWithUsModel {
  AdvertiseWithUsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory AdvertiseWithUsModel.fromJson(Map<String, dynamic> json) => AdvertiseWithUsModel(
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
    this.key,
    this.message,
  });

  String key;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    key: json["key"] == null ? null : json["key"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "message": message == null ? null : message,
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