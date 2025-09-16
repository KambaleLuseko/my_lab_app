import 'package:my_lab_app/Resources/Models/user.model.dart';
import 'package:my_lab_app/Views/Rooms/model/room.model.dart';

class RoomManagerModel {
  int? id;
  String? uuid;
  String? roomUuid;
  String? userUuid;
  String? date;
  Null startTime;
  Null endTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  RoomModel? room;
  UserModel? user;
  RoomManagerModel({
    this.id,
    this.uuid,
    this.roomUuid,
    this.userUuid,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.room,
    this.user,
  });

  RoomManagerModel.fromJson(Map json) {
    id = json['id'];
    uuid = json['uuid'];
    roomUuid = json['room_uuid'];
    userUuid = json['user_uuid'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? RoomModel.fromJson(json['room']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map toJson() {
    final Map data = {};
    data['id'] = id;
    data['uuid'] = uuid;
    data['room_uuid'] = roomUuid;
    data['user_uuid'] = userUuid;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status ?? 'Active';
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data.removeWhere(
      (key, value) => value == null || (value?.toString() ?? '').isEmpty,
    );
    return data;
  }
}
