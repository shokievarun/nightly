// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      parentId: fields[0] as String?,
      name: fields[1] as String?,
      menuItems: (fields[2] as List?)?.cast<Menuitem>(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.parentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.menuItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuitemAdapter extends TypeAdapter<Menuitem> {
  @override
  final int typeId = 3;

  @override
  Menuitem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Menuitem(
      id: fields[0] as String?,
      parentId: fields[1] as String?,
      isVeg: fields[2] as bool?,
      active: fields[3] as bool?,
      name: fields[4] as String?,
      price: fields[5] as double?,
      image: fields[6] as String?,
      description: fields[7] as String?,
      count: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Menuitem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parentId)
      ..writeByte(2)
      ..write(obj.isVeg)
      ..writeByte(3)
      ..write(obj.active)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuitemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 4;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      userId: fields[0] as String,
      orderStatus: fields[1] as String,
      restaurantId: fields[2] as String,
      name: fields[3] as String,
      image: fields[4] as String,
      menuItems: (fields[5] as List).cast<Menuitem>(),
      lastOpenedDateTime: fields[6] as DateTime,
      paymentType: fields[7] as String,
      totalAmount: fields[8] as num,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.orderStatus)
      ..writeByte(2)
      ..write(obj.restaurantId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.menuItems)
      ..writeByte(6)
      ..write(obj.lastOpenedDateTime)
      ..writeByte(7)
      ..write(obj.paymentType)
      ..writeByte(8)
      ..write(obj.totalAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
