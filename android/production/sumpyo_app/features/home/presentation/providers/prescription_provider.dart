import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../domain/entities/prescription.dart";
import "../../data/providers/data_providers.dart";

part "prescription_provider.g.dart";

@riverpod
class PrescriptionNotifier extends _$PrescriptionNotifier {
  @override
  FutureOr<List<Prescription>> build() async {
    return ref.watch(prescriptionRepositoryProvider).getPrescriptions();
  }

  Future<void> generatePrescription(String prompt, String style) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prescriptionRepositoryProvider).generatePrescription(prompt, style);
      return ref.read(prescriptionRepositoryProvider).getPrescriptions();
    });
  }
}
