// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part "photo_model.g.dart";

@HiveType(typeId: 0)
class PhotoModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double width;
  @HiveField(2)
  final double height;
  @HiveField(3)
  final Map<String, String> src;
  @HiveField(4)
  final String photographerName;
  @HiveField(5)
  final String photographerUrl;
  @HiveField(6)
  final int photographerId;
  @HiveField(7)
  final String avgColor;
  @HiveField(8)
  final String alt;
  @HiveField(9)
  bool isDownloaded;
  PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.src,
    required this.photographerName,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.alt,
    this.isDownloaded = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'width': width,
      'height': height,
      'src': src,
      'photographer_name': photographerName,
      'photographer_url': photographerUrl,
      'photographer_id': photographerId,
      'avg_color': avgColor,
      'alt': alt,
      'isDownloaded': isDownloaded,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'] as int,
      width: double.parse(map['width'].toString()),
      height: double.parse(map['height'].toString()),
      src: Map<String, String>.from((map['src'] as Map<String, String>)),
      photographerName: map['photographer'] as String,
      photographerUrl: map['photographer_url'] as String,
      photographerId: map['photographer_id'] as int,
      avgColor: map['avg_color'] as String,
      alt: map['alt'] as String,
      isDownloaded: map['isDownloaded'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(String source) =>
      PhotoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
