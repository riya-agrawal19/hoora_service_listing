// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) =>
    _ServiceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      image: json['image'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$ServiceModelToJson(_ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'isFavorite': instance.isFavorite,
    };
