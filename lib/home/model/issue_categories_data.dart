class IssueCategorieData {
  int? id;
  String? name;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  IssueCategorieData(
      {this.id,
      this.name,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt});

  IssueCategorieData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
