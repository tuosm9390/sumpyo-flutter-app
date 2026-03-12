import "package:hive/hive.dart";
import "../models/prescription_model.dart";

class PrescriptionLocalDataSource {
  static const String boxName = "prescriptions";

  Future<void> cachePrescription(PrescriptionModel prescription) async {
    final box = await Hive.openBox(boxName);
    await box.put(prescription.id, prescription.toJson());
  }

  Future<List<PrescriptionModel>> getCachedPrescriptions() async {
    final box = await Hive.openBox(boxName);
    final List<dynamic> rawList = box.values.toList();
    return rawList
        .map((e) => PrescriptionModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
