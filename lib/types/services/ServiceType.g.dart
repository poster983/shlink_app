// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceTypeAdapter extends TypeAdapter<ServiceType> {
  @override
  final int typeId = 2;

  @override
  ServiceType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServiceType.Shlink;
      case 1:
        return ServiceType.Kuttit;
      case 2:
        return ServiceType.GenericREST;
      default:
        return ServiceType.Shlink;
    }
  }

  @override
  void write(BinaryWriter writer, ServiceType obj) {
    switch (obj) {
      case ServiceType.Shlink:
        writer.writeByte(0);
        break;
      case ServiceType.Kuttit:
        writer.writeByte(1);
        break;
      case ServiceType.GenericREST:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
