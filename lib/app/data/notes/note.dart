import "package:cloud_firestore/cloud_firestore.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:menyusha/app/common/timestamp_serializer.dart";
import "package:menyusha/app/data/repository/base_model.dart";

class Note implements BaseModel {
  final String userId;
  final String? id;
  final DateTime? creationDate;
  final String content;

  Note({
    required this.userId,
    required this.id,
    required this.creationDate,
    required this.content,
  });

  factory Note.fromJson(final Map<String, dynamic> json) {
    return Note(
      userId: json['userId'] as String,
      id: json['id'] as String?,
      creationDate: json['creationDate'] == null ? null : DateTime.parse(json['creationDate'] as String),
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'creationDate': creationDate?.toIso8601String(),
      'content': content,
    };
  }

  Note copyWith({
    String? userId,
    String? id,
    DateTime? creationDate,
    String? content,
  }) {
    return Note(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      content: content ?? this.content,
    );
  }

  @override
  BaseModel copyWithId({final String? id}) {
    return Note(
      userId: userId,
      id: id,
      creationDate: creationDate,
      content: content,
    );
  }
}
