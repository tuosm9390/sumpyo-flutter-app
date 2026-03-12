import "../../domain/entities/prescription.dart";
import "../../domain/repositories/prescription_repository.dart";
import "../datasources/ai_remote_datasource.dart";
import "../datasources/prescription_local_datasource.dart";
import "../models/prescription_model.dart";

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final AIRemoteDataSource remoteDataSource;
  final PrescriptionLocalDataSource localDataSource;

  PrescriptionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<List<Prescription>> getPrescriptions() async {
    final models = await localDataSource.getCachedPrescriptions();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Prescription> generatePrescription(String prompt, String style) async {
    final model = await remoteDataSource.generatePrescription(prompt, style);
    await localDataSource.cachePrescription(model);
    return model.toEntity();
  }
}
