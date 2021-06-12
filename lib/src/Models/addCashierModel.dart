// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AddCashierModel welcomeFromJson(String str) => AddCashierModel.fromJson(json.decode(str));

String welcomeToJson(AddCashierModel data) => json.encode(data.toJson());

class AddCashierModel {
  AddCashierModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory AddCashierModel.fromJson(Map<String, dynamic> json) => AddCashierModel(
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
    this.phone,
    this.name,
    this.active,
    this.apiToken,
    this.description,
    this.language,
    this.latitude,
    this.longitude,
    this.image,
    this.userId,
    this.transactions,
    this.createdAt,
  });

  int id;
  String phone;
  String name;
  int active;
  String apiToken;
  String description;
  String language;
  String latitude;
  String longitude;
  String image;
  int userId;
  dynamic transactions;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    phone: json["phone"] == null ? null : json["phone"],
    name: json["name"] == null ? null : json["name"],
    active: json["active"] == null ? null : json["active"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    description: json["description"] == null ? null : json["description"],
    language: json["language"] == null ? null : json["language"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    image: json["image"] == null ? null : json["image"],
    userId: json["user_id"] == null ? null : json["user_id"],
    transactions: json["transactions"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "phone": phone == null ? null : phone,
    "name": name == null ? null : name,
    "active": active == null ? null : active,
    "api_token": apiToken == null ? null : apiToken,
    "description": description == null ? null : description,
    "language": language == null ? null : language,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "image": image == null ? null : image,
    "user_id": userId == null ? null : userId,
    "transactions": transactions,
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