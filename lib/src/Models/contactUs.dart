// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ContactUsModel welcomeFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String welcomeToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
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
    this.message,
  });

  int id;
  int userId;
  String userName;
  String message;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "user_name": userName == null ? null : userName,
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