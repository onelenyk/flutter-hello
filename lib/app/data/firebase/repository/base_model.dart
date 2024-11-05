import 'package:cloud_firestore/cloud_firestore.dart';
import "package:freezed_annotation/freezed_annotation.dart";

mixin BaseModel {
  String? get id;

  Map<String, dynamic> toJson();
  BaseModel copyWithId({final String? id});
}
