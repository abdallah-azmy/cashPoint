// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GeneralSliderModel welcomeFromJson(String str) => GeneralSliderModel.fromJson(json.decode(str));

String welcomeToJson(GeneralSliderModel data) => json.encode(data.toJson());

class GeneralSliderModel {
  GeneralSliderModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory GeneralSliderModel.fromJson(Map<String, dynamic> json) => GeneralSliderModel(
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
    this.adminId,
    this.link,
    this.image,
    this.createdAt,
    this.categoryId,
    this.status,
    this.typeOfAdvertisement,
  });

  int id;
  int userId;
  int adminId;
  String link;
  String image;
  DateTime createdAt;
  dynamic categoryId;
  int status;
  int typeOfAdvertisement;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    adminId: json["admin_id"] == null ? null : json["admin_id"],
    link: json["link"] == null ? null : json["link"],
    image: json["image"] == null ? null : json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    categoryId: json["category_id "],
    status: json["status"] == null ? null : json["status"],
    typeOfAdvertisement: json["type_of_advertisement"] == null ? null : json["type_of_advertisement"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "admin_id": adminId == null ? null : adminId,
    "link": link == null ? null : link,
    "image": image == null ? null : image,
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "category_id ": categoryId,
    "status": status == null ? null : status,
    "type_of_advertisement": typeOfAdvertisement == null ? null : typeOfAdvertisement,


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