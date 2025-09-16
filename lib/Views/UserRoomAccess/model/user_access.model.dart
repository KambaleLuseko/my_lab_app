import 'package:my_lab_app/Resources/Models/user.model.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';

class UserAccessModel {
  int? id;
  String? uuid;
  String? userUuid;
  String? roomUuid;
  String? date;
  String? startTime;
  String? endTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  UserModel? user;
  RoomModel? room;

  UserAccessModel({
    this.id,
    this.uuid,
    this.userUuid,
    this.roomUuid,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.room,
  });

  UserAccessModel.fromJson(Map json) {
    id = json['id'];
    uuid = json['uuid'];
    userUuid = json['user_uuid'];
    roomUuid = json['room_uuid'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    room = json['room'] != null ? RoomModel.fromJson(json['room']) : null;
  }

  Map toJson() {
    final Map data = {};
    data['id'] = id;
    data['uuid'] = uuid;
    data['user_uuid'] = userUuid;
    data['room_uuid'] = roomUuid;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (room != null) {
      data['room'] = room!.toJson();
    }
    data.removeWhere(
      (key, value) => value == null || (value?.toString() ?? '').isEmpty,
    );
    return data;
  }
}
