import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
abstract class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
    required String id,
    required String title,
    required String category,
    required String description,
    required int price,
    required String image,
    @Default(false) bool isFavorite,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
}