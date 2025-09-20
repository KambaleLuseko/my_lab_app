// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'package:my_lab_app/Views/RoomManager/model/room_manager.model.dart';

class UserModel {
  int? id;
  String? uuid;
  String? name;
  String? phone;
  String? address;
  String? role;
  String? promotion;
  String? profile;
  String? anneeAcademique;
  String? email;
  Null emailVerifiedAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? password;

  UserModel({
    this.id,
    this.uuid,
    this.name,
    this.phone,
    this.address,
    this.role,
    this.promotion,
    this.profile,
    this.anneeAcademique,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.password,
  });

  UserModel.fromJson(Map json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    role = json['role'];
    promotion = json['promotion'];
    profile = json['profile'];
    anneeAcademique = json['annee_academique']?.toString();
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map toJson() {
    final Map data = {};
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['role'] = role;
    data['promotion'] = promotion;
    data['profile'] = profile;
    data['annee_academique'] = anneeAcademique;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['password'] = password;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data.removeWhere(
      (key, value) => (value?.toString() ?? '').isEmpty || value == null,
    );
    return data;
  }
}

class AuthModel {
  UserModel user;
  String? token;
  RoomManagerModel? roomManager;
  AuthModel({required this.user, this.token, this.roomManager});

  static fromJSON(json) {
    return AuthModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
      roomManager: json['roomAccess'],
    );
  }

  toJSON() {
    Map data = {
      "user": user.toJson(),
      'token': token,
      "roomAccess": roomManager?.toJson(),
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
