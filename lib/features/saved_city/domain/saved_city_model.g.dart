// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedCityModelAdapter extends TypeAdapter<SavedCityModel> {
  @override
  final int typeId = 0;

  @override
  SavedCityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedCityModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      lat: fields[2] as double?,
      long: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedCityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedCityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
