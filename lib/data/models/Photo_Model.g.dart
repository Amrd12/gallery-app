// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Photo_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoModelAdapter extends TypeAdapter<PhotoModel> {
  @override
  final int typeId = 0;

  @override
  PhotoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoModel(
      id: fields[0] as int,
      width: fields[1] as double,
      height: fields[2] as double,
      src: (fields[3] as Map).cast<String, String>(),
      photographer_name: fields[4] as String,
      photographer_url: fields[5] as String,
      photographer_id: fields[6] as int,
      avg_color: fields[7] as String,
      alt: fields[8] as String,
      Like: fields[10] as bool,
      isdownloaded: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.src)
      ..writeByte(4)
      ..write(obj.photographer_name)
      ..writeByte(5)
      ..write(obj.photographer_url)
      ..writeByte(6)
      ..write(obj.photographer_id)
      ..writeByte(7)
      ..write(obj.avg_color)
      ..writeByte(8)
      ..write(obj.alt)
      ..writeByte(9)
      ..write(obj.isdownloaded)
      ..writeByte(10)
      ..write(obj.Like);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
