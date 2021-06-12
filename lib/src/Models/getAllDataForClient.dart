// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AllDataModelForClient welcomeFromJson(String str) => AllDataModelForClient.fromJson(json.decode(str));

String welcomeToJson(AllDataModelForClient data) => json.encode(data.toJson());

class AllDataModelForClient {
  AllDataModelForClient({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory AllDataModelForClient.fromJson(Map<String, dynamic> json) => AllDataModelForClient(
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
    this.email,
    this.phone,
    this.name,
    this.type,
    this.active,
    this.apiToken,
    this.membershipNum,
    this.image,
    this.lastLoginAt,
    this.countryId,
    this.country,
    this.qrcode,
    this.ratesClient,
    this.memberId,
    this.member,
    this.createdAt,
  });

  int id;
  String phone;
  String email;
  String name;
  int type;
  int active;
  String apiToken;
  String membershipNum;
  String image;
  dynamic lastLoginAt;
  int countryId;
  List<Country> country;
  String qrcode;
  dynamic ratesClient;
  int memberId;
  Member member;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    active: json["active"] == null ? null : json["active"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    membershipNum: json["membership_num"] == null ? null : "${json["membership_num"]}",
    image: json["image"] == null ? null : json["image"],
    lastLoginAt: json["last_login_at"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    country: json["country"] == null ? null : List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    qrcode: json["qrcode"] == null ? null : json["qrcode"],
    ratesClient: json["ratesClient"],
    memberId: json["member_id"] == null ? null : json["member_id"],
    member: json["member"] == null ? null : Member.fromJson(json["member"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "phone": phone == null ? null : phone,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "type": type == null ? null : type,
    "active": active == null ? null : active,
    "api_token": apiToken == null ? null : apiToken,
    "membership_num": membershipNum == null ? null : membershipNum,
    "image": image == null ? null : image,
    "last_login_at": lastLoginAt,
    "country_id": countryId == null ? null : countryId,
    "country": country == null ? null : List<dynamic>.from(country.map((x) => x.toJson())),
    "qrcode": qrcode == null ? null : qrcode,
    "ratesClient": ratesClient,
    "member_id": memberId == null ? null : memberId,
    "member": member == null ? null : member.toJson(),
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}

class Country {
  Country({
    this.id,
    this.name,
    this.code,
    this.currency,
    this.image,
    this.createdAt,
  });

  int id;
  String name;
  int code;
  String currency;
  String image;
  DateTime createdAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    code: json["code"] == null ? null : json["code"],
    currency: json["currency"] == null ? null : json["currency"],
    image: json["image"] == null ? null : json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "code": code == null ? null : code,
    "currency": currency == null ? null : currency,
    "image": image == null ? null : image,
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}

class Member {
  Member({
    this.id,
    this.point,
    this.title,
    this.createdAt,
  });

  int id;
  dynamic point;
  String title;
  DateTime createdAt;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"] == null ? null : json["id"],
    point: json["point"],
    title: json["title"] == null ? null : json["title"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "point": point,
    "title": title == null ? null : title,
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