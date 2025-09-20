import 'package:my_lab_app/Views/Rooms/model/room.model.dart';

class ServiceModel {
  int? id;
  String? uuid;
  String? name;
  String? description;
  int? sallesId;
  String? createdAt;
  String? updatedAt;
  RoomModel? room;

  ServiceModel({
    this.id,
    this.uuid,
    this.name,
    this.description,
    this.sallesId,
    this.createdAt,
    this.updatedAt,
    this.room,
  });

  ServiceModel.fromJson(Map json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    description = json['description'];
    sallesId = json['salles_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? RoomModel.fromJson(json['room']) : null;
  }

  Map toJson() {
    final Map data = {};
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['description'] = description;
    data['salles_id'] = sallesId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    return data;
  }
}
