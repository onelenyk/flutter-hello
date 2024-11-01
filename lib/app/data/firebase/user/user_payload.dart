import "package:cloud_firestore/cloud_firestore.dart";
import "package:uuid/uuid.dart";

import "../../repository/base_model.dart";

class UserPayload implements BaseModel {
  UserPayload({
    required this.id,
    required this.uid,
  });

  // Convert JSON to UserPayload
  factory UserPayload.fromJson(Map<String, dynamic> json) => UserPayload(
      id: json['id'] as String,
      uid: json['uid'] as String,
    );

  @override
  final String id;
  final String uid;


  // Copy with new values, including id
  UserPayload copyWith({
    String? id,
    String? uid,
  }) =>
      UserPayload(
        id: id ?? this.id,
        uid: uid ?? this.uid,
      );

  // Implement copyWithId from BaseModel
  @override
  UserPayload copyWithId({final String? id}) => copyWith(id: id);

  // Convert UserPayload to JSON
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
  };
}