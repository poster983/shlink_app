// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortUrl.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortUrlAdapter extends TypeAdapter<ShortUrl> {
  @override
  final int typeId = 0;

  @override
  ShortUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortUrl(
      longUrl: fields[0] as Uri,
      shortUrl: fields[1] as Uri,
      slug: fields[2] as String,
      dateCreated: fields[3] as DateTime,
      visitCount: fields[4] as int,
      tags: (fields[5] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShortUrl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.longUrl)
      ..writeByte(1)
      ..write(obj.shortUrl)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.dateCreated)
      ..writeByte(4)
      ..write(obj.visitCount)
      ..writeByte(5)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortUrl _$ShortUrlFromJson(Map<String, dynamic> json) {
  return ShortUrl(
    longUrl: Uri.parse(json['longUrl'] as String),
    shortUrl: Uri.parse(json['shortUrl'] as String),
    slug: json['slug'] as String,
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    visitCount: json['visitCount'] as int,
    tags: (json['tags'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ShortUrlToJson(ShortUrl instance) => <String, dynamic>{
      'longUrl': instance.longUrl.toString(),
      'shortUrl': instance.shortUrl.toString(),
      'slug': instance.slug,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'visitCount': instance.visitCount,
      'tags': instance.tags,
    };
