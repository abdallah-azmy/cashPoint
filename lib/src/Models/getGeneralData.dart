// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GeneralDataModel welcomeFromJson(String str) => GeneralDataModel.fromJson(json.decode(str));

String welcomeToJson(GeneralDataModel data) => json.encode(data.toJson());

class GeneralDataModel {
  GeneralDataModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory GeneralDataModel.fromJson(Map<String, dynamic> json) => GeneralDataModel(
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
    this.bankName,
    this.bankAccount,
    this.term,
    this.condition,
    this.description,
    this.logo,
    this.minLimitReplacement,
    this.clientCash,
    this.maxCommission,
    this.scopeOfSearch,
    this.twitter,
    this.instagram,
    this.facebook,
    this.phone,
    this.minText,
    this.subMinText,
    this.createdAt,
  });

  int id;
  String bankName;
  String bankAccount;
  String term;
  String condition;
  dynamic description;
  String logo;
  int minLimitReplacement;
  int clientCash;
  String maxCommission;
  int scopeOfSearch;
  dynamic twitter;
  dynamic instagram;
  dynamic facebook;
  dynamic phone;
  dynamic subMinText;
  dynamic minText;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    bankName: json["bank_name"] == null ? null : json["bank_name"],
    bankAccount: json["bank_account"] == null ? null : json["bank_account"],
    term: json["term"] == null ? null : json["term"],
    condition: json["condition"] == null ? null : json["condition"],
    description: json["description"],
    logo: json["logo"] == null ? null : json["logo"],
    minLimitReplacement: json["min_limit_replacement"] == null ? null : json["min_limit_replacement"],
    clientCash: json["client_cash"] == null ? null : json["client_cash"],
    maxCommission: json["max_commission"] == null ? null : "${json["max_commission"]}",
    scopeOfSearch: json["scope_of_search"] == null ? null : json["scope_of_search"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    phone: json["phone"],
    minText: json["min_text"],
    subMinText: json["sub_min_text"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bank_name": bankName == null ? null : bankName,
    "bank_account": bankAccount == null ? null : bankAccount,
    "term": term == null ? null : term,
    "condition": condition == null ? null : condition,
    "description": description,
    "logo": logo == null ? null : logo,
    "min_limit_replacement": minLimitReplacement == null ? null : minLimitReplacement,
    "client_cash": clientCash == null ? null : clientCash,
    "max_commission": maxCommission == null ? null : maxCommission,
    "scope_of_search": scopeOfSearch == null ? null : scopeOfSearch,
    "twitter": twitter,
    "instagram": instagram,
    "facebook": facebook,
    "phone": phone,
    "min_text": minText,
    "sub_min_text": subMinText,
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