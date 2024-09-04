// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'search_model.g.dart';

@HiveType(typeId: 1)
class SearchModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final int results;
  @HiveField(3)
  final String type;

  SearchModel({
    required this.name,
    required this.date,
    required this.results,
    required this.type,
  });

  SearchModel copyWith({
    String? name,
    String? date,
    int? results,
    String? type,
  }) {
    return SearchModel(
      name: name ?? this.name,
      date: date ?? this.date,
      results: results ?? this.results,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date,
      'results': results,
      'type': type,
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      name: map['name'] as String,
      date: map['date'] as String,
      results: map['results'] as int,
      type: map['type'] as String,
    );
  }

  String toJson() => JsonEncoder.withIndent("    ").convert(toMap());

  factory SearchModel.fromJson(String source) =>
      SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SearchModel(name: $name, date: $date, results: $results, type: $type)';
  }

  @override
  bool operator ==(covariant SearchModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.date == date &&
        other.results == results &&
        other.type == type;
  }

  @override
  int get hashCode {
    return name.hashCode ^ date.hashCode ^ results.hashCode ^ type.hashCode;
  }
}
