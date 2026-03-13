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

  Future<Prescription?> generatePrescription(
      String prompt, String style) async {
    final repository = ref.read(prescriptionRepositoryProvider);
    state = const AsyncValue.loading();

    try {
      final newPrescription =
          await repository.generatePrescription(prompt, style);
      final prescriptions = await repository.getPrescriptions();
      state = AsyncValue.data(prescriptions);
      return newPrescription;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}
