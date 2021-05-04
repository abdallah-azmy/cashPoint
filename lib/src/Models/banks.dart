// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BanksModel welcomeFromJson(String str) => BanksModel.fromJson(json.decode(str));

String welcomeToJson(BanksModel data) => json.encode(data.toJson());

class BanksModel {
  BanksModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<DatumBanks> data;
  List<Error> error;

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
    mainCode: json["mainCode"] == null ? null : json["mainCode"],
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : List<DatumBanks>.from(json["data"].map((x) => DatumBanks.fromJson(x))),
    error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mainCode": mainCode == null ? null : mainCode,
    "code": code == null ? null : code,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class DatumBanks {
  DatumBanks({
    this.id,
    this.name,
    this.createdAt,
  });

  int id;
  String name;
  DateTime createdAt;

  factory DatumBanks.fromJson(Map<String, dynamic> json) => DatumBanks(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
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