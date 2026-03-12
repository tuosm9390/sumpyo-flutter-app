import "package:freezed_annotation/freezed_annotation.dart";

part "prescription.freezed.dart";

@freezed
abstract class Prescription with _$Prescription {
  const factory Prescription({
    required String id,
    required String title,
    required String content,
    required String quote,
  }) = _Prescription;
}
