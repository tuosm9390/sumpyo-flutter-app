import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/prescription.dart';

part 'prescription_model.freezed.dart';
part 'prescription_model.g.dart';

@freezed
abstract class PrescriptionModel with _$PrescriptionModel {
  const factory PrescriptionModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String content,
    @Default('') String quote,
    @Default('') String emotion,
    @Default('') String style,
  }) = _PrescriptionModel;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);

  factory PrescriptionModel.fromEntity(Prescription entity) =>
      PrescriptionModel(
        id: entity.id,
        title: entity.title,
        content: entity.content,
        quote: entity.quote,
        emotion: entity.emotion,
        style: entity.style,
      );

  const PrescriptionModel._();

  Prescription toEntity() => Prescription(
        id: id,
        title: title.replaceAll(r'\n', '\n'),
        content: content.replaceAll(r'\n', '\n'),
        quote: quote.replaceAll(r'\n', '\n'),
        emotion: emotion.replaceAll(r'\n', '\n'),
        style: style,
      );
}
