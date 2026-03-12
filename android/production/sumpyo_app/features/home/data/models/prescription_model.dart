import "package:freezed_annotation/freezed_annotation.dart";
import "../../domain/entities/prescription.dart";

part "prescription_model.freezed.dart";
part "prescription_model.g.dart";

@freezed
abstract class PrescriptionModel with _$PrescriptionModel {
  const factory PrescriptionModel({
    required String id,
    required String title,
    required String content,
    required String quote,
  }) = _PrescriptionModel;

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);

  factory PrescriptionModel.fromEntity(Prescription entity) =>
      PrescriptionModel(
        id: entity.id,
        title: entity.title,
        content: entity.content,
        quote: entity.quote,
      );

  const PrescriptionModel._();

  Prescription toEntity() => Prescription(
        id: id,
        title: title,
        content: content,
        quote: quote,
      );
}
