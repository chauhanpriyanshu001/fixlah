class FaceLoginData {
  bool? success;
  String? message;
  String? token;
  bool? remember;
  User? user;

  FaceLoginData(
      {this.success, this.message, this.token, this.remember, this.user});

  FaceLoginData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    remember = json['remember'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['remember'] = this.remember;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Roles? roles;
  List<String>? permissions;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.roles,
      this.permissions});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.roles != null) {
      data['roles'] = this.roles!.toJson();
    }
    data['permissions'] = this.permissions;
    return data;
  }
}

class Roles {
  int? id;
  String? referenceUuid;
  String? name;
  String? guardName;
  String? description;
  String? createdAt;
  String? updatedAt;

  Roles(
      {this.id,
      this.referenceUuid,
      this.name,
      this.guardName,
      this.description,
      this.createdAt,
      this.updatedAt});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    name = json['name'];
    guardName = json['guard_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
