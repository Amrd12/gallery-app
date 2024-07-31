// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';
part 'Photo_Model.g.dart';

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
  final String photographer_name;
  @HiveField(5)
  final String photographer_url;
  @HiveField(6)
  final int photographer_id;
  @HiveField(7)
  final String avg_color;
  @HiveField(8)
  final String alt;
  @HiveField(9)
  bool isdownloaded;
  @HiveField(10)
  bool Like;
  PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.src,
    required this.photographer_name,
    required this.photographer_url,
    required this.photographer_id,
    required this.avg_color,
    required this.alt,
    this.Like = false,
    this.isdownloaded = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'width': width,
      'height': height,
      'src': src,
      'photographer_name': photographer_name,
      'photographer_url': photographer_url,
      'photographer_id': photographer_id,
      'avg_color': avg_color,
      'alt': alt,
      'isdownloaded': isdownloaded,
      "like": Like
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'] as int,
      width: double.parse(map['width'].toString()),
      height: double.parse(map['height'].toString()),
      src: Map<String, String>.from((map['src'] as Map<String, String>)),
      photographer_name: map['photographer'] as String,
      photographer_url: map['photographer_url'] as String,
      photographer_id: map['photographer_id'] as int,
      avg_color: map['avg_color'] as String,
      alt: map['alt'] as String,
      isdownloaded: map['isdownloaded'] as bool,
      Like: map['Like'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(String source) =>
      PhotoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
