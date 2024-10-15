// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: (json['id'] as num?)?.toInt(),
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      initialPrice: (json['initialPrice'] as num?)?.toInt(),
      productPrice: (json['productPrice'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      unit: json['unit'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'initialPrice': instance.initialPrice,
      'productPrice': instance.productPrice,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'image': instance.image,
    };
