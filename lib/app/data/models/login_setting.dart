// import 'dart:convert';

// LoginSetting loginResponseModelFromJson(String str) =>
//     LoginSetting.fromJson(json.decode(str));

// String loginResponseModelToJson(LoginSetting data) =>
//     json.encode(data.toJson());

class LoginSetting {
  LoginSetting({
    required this.access_token,
    required this.expires_in,
    required this.data,
  });

  String access_token;
  int expires_in;
  Data data;

  factory LoginSetting.fromJson(Map<String, dynamic> json) => LoginSetting(
        access_token: json["access_token"],
        expires_in: json["expires_in"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": access_token,
        "expires_in": expires_in,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.uuid,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    // required this.token,
    // required this.tokenType,
  });

  String uuid;
  String username;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  // String token;
  // String tokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uuid: json["uuid"],
        username: json["username"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // token: json["token"],
        // tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "username": username,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "token": token,
        // "token_type": tokenType,
      };
}
