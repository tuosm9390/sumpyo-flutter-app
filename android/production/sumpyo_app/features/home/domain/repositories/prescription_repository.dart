import "../entities/prescription.dart";

abstract class PrescriptionRepository {
  Future<List<Prescription>> getPrescriptions();
  Future<Prescription> generatePrescription(String prompt, String style);
}
