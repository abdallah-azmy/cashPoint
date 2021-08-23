import 'dart:convert';

LogIn welcomeFromJson(String str) => LogIn.fromJson(json.decode(str));

String welcomeToJson(LogIn data) => json.encode(data.toJson());

class LogIn {
  LogIn({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory LogIn.fromJson(Map<String, dynamic> json) => LogIn(
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
    this.bankId,
    this.bank,
    this.type,
    this.categoryId,
    this.category,
    this.active,
    this.apiToken,
    this.description,
    this.latitude,
    this.longitude,
    this.membershipNum,
    this.commission,
    this.logo,
    this.image,
    this.file,
    this.arranging,
    this.lastLoginAt,
    this.tradeRegister,
    this.bankAccount,
    this.pointEqualSr,
    this.countryId,
    this.country,
    this.sliders,
    this.ratesStore,
    this.stars,
    this.coupon,
    this.createdAt,
  });

  int id;
  String phone;
  String name;
  dynamic bankId;
  dynamic bank;
  int type;
  int categoryId;
  List<Category> category;
  int active;
  String apiToken;
  String description;
  String latitude;
  String longitude;
  String membershipNum;
  String commission;
  String logo;
  String image;
  String file;
  int arranging;
  String lastLoginAt;
  String tradeRegister;
  dynamic bankAccount;
  int pointEqualSr;
  int countryId;
  List<Country> country;
  List<Slider> sliders;
  dynamic ratesStore;
  String stars;
  dynamic coupon;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    phone: json["phone"] == null ? null : json["phone"],
    name: json["name"] == null ? null : json["name"],
    bankId: json["bank_id"],
    bank: json["bank"],
    type: json["type"] == null ? null : json["type"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    active: json["active"] == null ? null : json["active"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    description: json["description"] == null ? null : json["description"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    membershipNum: json["membership_num"] == null ? null : "${json["membership_num"]}",
    commission: json["commission"] == null ? null : "${json["commission"]}",
    logo: json["logo"] == null ? null : json["logo"],
    image: json["image"] == null ? null : json["image"],
    file: json["file"] == null ? null : json["file"],
    arranging: json["arranging"] == null ? null : json["arranging"],
    lastLoginAt: json["last_login_at"] == null ? null : json["last_login_at"],
    tradeRegister: json["trade_register"] == null ? null : json["trade_register"],
    bankAccount: json["bank_account"],
    pointEqualSr: json["point_equal_SR"] == null ? null : json["point_equal_SR"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    country: json["country"] == null ? null : List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    sliders: json["sliders"] == null ? null : List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
    ratesStore: json["ratesStore"],
    stars: json["stars"] == null ? null : "${json["stars"]}",
    coupon: json["coupon"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "phone": phone == null ? null : phone,
    "name": name == null ? null : name,
    "bank_id": bankId,
    "bank": bank,
    "type": type == null ? null : type,
    "category_id": categoryId == null ? null : categoryId,
    "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
    "active": active == null ? null : active,
    "api_token": apiToken == null ? null : apiToken,
    "description": description == null ? null : description,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "membership_num": membershipNum == null ? null : membershipNum,
    "commission": commission == null ? null : commission,
    "logo": logo == null ? null : logo,
    "image": image == null ? null : image,
    "file": file == null ? null : file,
    "arranging": arranging == null ? null : arranging,
    "last_login_at": lastLoginAt == null ? null : lastLoginAt,
    "trade_register": tradeRegister == null ? null : tradeRegister,
    "bank_account": bankAccount,
    "point_equal_SR": pointEqualSr == null ? null : pointEqualSr,
    "country_id": countryId == null ? null : countryId,
    "country": country == null ? null : List<dynamic>.from(country.map((x) => x.toJson())),
    "sliders": sliders == null ? null : List<dynamic>.from(sliders.map((x) => x.toJson())),
    "ratesStore": ratesStore,
    "stars": stars == null ? null : stars,
    "coupon": coupon,
    "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.haveStores,
    this.createdAt,
  });

  int id;
  String name;
  String image;
  int haveStores;
  DateTime createdAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    haveStores: json["haveStores"] == null ? null : json["haveStores"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "haveStores": haveStores == null ? null : haveStores,
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

class Slider {
  Slider({
    this.id,
    this.userId,
    this.adminId,
    this.link,
    this.image,
    this.createdAt,
  });

  int id;
  int userId;
  int adminId;
  String link;
  String image;
  DateTime createdAt;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    adminId: json["admin_id"] == null ? null : json["admin_id"],
    link: json["link"] == null ? null : json["link"],
    image: json["image"] == null ? null : json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "admin_id": adminId == null ? null : adminId,
    "link": link == null ? null : link,
    "image": image == null ? null : image,
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

