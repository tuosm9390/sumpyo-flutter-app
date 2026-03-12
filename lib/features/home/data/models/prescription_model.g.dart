// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrescriptionModel _$PrescriptionModelFromJson(Map<String, dynamic> json) =>
    _PrescriptionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      quote: json['quote'] as String? ?? '',
      emotion: json['emotion'] as String? ?? '',
      style: json['style'] as String? ?? '',
    );

Map<String, dynamic> _$PrescriptionModelToJson(_PrescriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'quote': instance.quote,
      'emotion': instance.emotion,
      'style': instance.style,
    };
