import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_chat_app_ui/models/user_model.dart';

class GroupChatModel {
  int id;
  String group_name;
  String group_description;
  List<UserModel> group_members;
  UserModel group_admin;
  String group_link;
  String group_image;

  GroupChatModel(
    this.id,
    this.group_name,
    this.group_description,
    this.group_members,
    this.group_admin,
    this.group_link,
    this.group_image,
  );

  GroupChatModel copyWith({
    int? id,
    String? group_name,
    String? group_description,
    List<UserModel>? group_members,
    UserModel? group_admin,
    String? group_link,
    String? group_image,
  }) {
    return GroupChatModel(
      id ?? this.id,
      group_name ?? this.group_name,
      group_description ?? this.group_description,
      group_members ?? this.group_members,
      group_admin ?? this.group_admin,
      group_link ?? this.group_link,
      group_image ?? this.group_image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'group_name': group_name});
    result.addAll({'group_description': group_description});
    result.addAll(
        {'group_members': group_members.map((x) => x.toMap()).toList()});
    result.addAll({'group_admin': group_admin.toMap()});
    result.addAll({'group_link': group_link});
    result.addAll({'group_image': group_image});

    return result;
  }

  factory GroupChatModel.fromMap(Map<String, dynamic> map) {
    return GroupChatModel(
      map['id']?.toInt() ?? 0,
      map['group_name'] ?? '',
      map['group_description'] ?? '',
      List<UserModel>.from(
          map['group_members']?.map((x) => UserModel.fromMap(x))),
      UserModel.fromMap(map['group_admin']),
      map['group_link'] ?? '',
      map['group_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupChatModel.fromJson(String source) =>
      GroupChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupChatModel(id: $id, group_name: $group_name, group_description: $group_description, group_members: $group_members, group_admin: $group_admin, group_link: $group_link, group_image: $group_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupChatModel &&
        other.id == id &&
        other.group_name == group_name &&
        other.group_description == group_description &&
        listEquals(other.group_members, group_members) &&
        other.group_admin == group_admin &&
        other.group_link == group_link &&
        other.group_image == group_image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        group_name.hashCode ^
        group_description.hashCode ^
        group_members.hashCode ^
        group_admin.hashCode ^
        group_link.hashCode ^
        group_image.hashCode;
  }
}
