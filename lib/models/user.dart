import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    email = json['email'] as String?;
    gender = json['gender'] as String?;
    status = json['status'] as String?;
  }
  int? id;
  String? name;
  String? email;
  String? gender;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['status'] = status;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, status];
}
