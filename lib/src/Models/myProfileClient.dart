// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyProfileClientModel welcomeFromJson(String str) => MyProfileClientModel.fromJson(json.decode(str));

String welcomeToJson(MyProfileClientModel data) => json.encode(data.toJson());

class MyProfileClientModel {
  MyProfileClientModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory MyProfileClientModel.fromJson(Map<String, dynamic> json) => MyProfileClientModel(
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
    this.userImage,
    this.qrcode,
    this.userMembershipNum,
    this.main,
    this.remain,
    this.pull,
    this.status,
    this.bankId,
    this.bank,
    this.bankAccount,
    this.cash,
    this.minLimitReplacement,
    this.memberId,
    this.member,
    this.lastLoginAt,
    this.email,
    this.allPointClientHave,
  });

  int id;
  int userId;
  String userName;
  String userPhone;
  String userImage;
  String qrcode;
  String userMembershipNum;
  int main;
  int remain;
  int pull;
  int status;
  int bankId;
  List<Bank> bank;
  String bankAccount;
  int cash;
  int minLimitReplacement;
  int memberId;
  Member member;
  String lastLoginAt;
  String email;
  int allPointClientHave;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    userImage: json["user_image"] == null ? null : json["user_image"],
    qrcode: json["qrcode"] == null ? null : json["qrcode"],
    userMembershipNum: json["user_membership_num"] == null ? null : json["user_membership_num"],
    main: json["main"] == null ? null : json["main"],
    remain: json["remain"] == null ? null : json["remain"],
    pull: json["pull"] == null ? null : json["pull"],
    status: json["status"] == null ? null : json["status"],
    bankId: json["bank_id"] == null ? null : json["bank_id"],
    bank: json["bank"] == null ? null : List<Bank>.from(json["bank"].map((x) => Bank.fromJson(x))),
    bankAccount: json["bank_account"] == null ? null : json["bank_account"],
    cash: json["cash"] == null ? null : json["cash"],
    minLimitReplacement: json["min_limit_replacement"] == null ? null : json["min_limit_replacement"],
    memberId: json["member_id"] == null ? null : json["member_id"],
    member: json["member"] == null ? null : Member.fromJson(json["member"]),
    lastLoginAt: json["last_login_at"] == null ? null : json["last_login_at"],
    email: json["email"] == null ? null : json["email"],
    allPointClientHave: json["allPointClientHave"] == null ? null : json["allPointClientHave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "user_name": userName == null ? null : userName,
    "user_phone": userPhone == null ? null : userPhone,
    "user_image": userImage == null ? null : userImage,
    "qrcode": qrcode == null ? null : qrcode,
    "user_membership_num": userMembershipNum == null ? null : userMembershipNum,
    "main": main == null ? null : main,
    "remain": remain == null ? null : remain,
    "pull": pull == null ? null : pull,
    "status": status == null ? null : status,
    "bank_id": bankId == null ? null : bankId,
    "bank": bank == null ? null : List<dynamic>.from(bank.map((x) => x.toJson())),
    "bank_account": bankAccount == null ? null : bankAccount,
    "cash": cash == null ? null : cash,
    "min_limit_replacement": minLimitReplacement == null ? null : minLimitReplacement,
    "member_id": memberId == null ? null : memberId,
    "member": member == null ? null : member.toJson(),
    "last_login_at": lastLoginAt == null ? null : lastLoginAt,
    "email": email == null ? null : email,
    "allPointClientHave": allPointClientHave == null ? null : allPointClientHave,
  };
}


class Bank {
  Bank({
    this.id,
    this.name,
    this.createdAt,
  });

  int id;
  String name;
  DateTime createdAt;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
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

class Member {
  Member({
    this.id,
    this.point,
    this.title,
    this.createdAt,
  });

  int id;
  int point;
  String title;
  DateTime createdAt;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"] == null ? null : json["id"],
    point: json["point"] == null ? null : json["point"],
    title: json["title"] == null ? null : json["title"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "point": point == null ? null : point,
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