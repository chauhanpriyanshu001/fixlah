class LoginResponse {
  bool? success;
  String? message;
  String? token;
  User? user;

  LoginResponse({this.success, this.message, this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
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
    roles = json['roles'] != null ? Roles.fromJson(json['roles']) : null;
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    if (roles != null) {
      data['roles'] = roles!.toJson();
    }
    data['permissions'] = permissions;
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? description;
  String? createdAt;
  String? updatedAt;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.description,
      this.createdAt,
      this.updatedAt});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['guard_name'] = guardName;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
