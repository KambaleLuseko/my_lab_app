class RoomModel {
  int? id;
  String? uuid;
  String? name;
  int? capacity;
  String? openedAt;
  String? closedAt;
  String? status;
  String? createdAt;
  String? updatedAt;

  RoomModel({
    this.id,
    this.uuid,
    this.name,
    this.capacity,
    this.openedAt,
    this.closedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  RoomModel.fromJson(Map json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    capacity = int.tryParse(json['capacity'].toString());
    openedAt = json['opened_at'];
    closedAt = json['closed_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map toJson() {
    final Map data = {};
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['capacity'] = capacity?.toString();
    data['opened_at'] = openedAt;
    data['closed_at'] = closedAt;
    data['status'] = status ?? 'Active';
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data.removeWhere(
      (key, value) => value == null || value!.toString().isEmpty,
    );
    return data;
  }
}
