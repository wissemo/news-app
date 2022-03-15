import 'dart:convert';

import 'package:equatable/equatable.dart';

class SourceModel extends Equatable {
  final String id;
  final String name;
  const SourceModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SourceModel.fromMap(Map<String, dynamic> map) {
    return SourceModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceModel.fromJson(String source) =>
      SourceModel.fromMap(json.decode(source));

  @override
  String toString() => 'SourceModel(id: $id, name: $name)';
}
