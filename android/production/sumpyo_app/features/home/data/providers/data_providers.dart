import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../../core/network/dio_client.dart";
import "../datasources/ai_remote_datasource.dart";
import "../datasources/prescription_local_datasource.dart";
import "../repositories/prescription_repository_impl.dart";
import "../../domain/repositories/prescription_repository.dart";

part "data_providers.g.dart";

@riverpod
AIRemoteDataSource aiRemoteDataSource(AiRemoteDataSourceRef ref) {
  return AIRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
PrescriptionLocalDataSource prescriptionLocalDataSource(PrescriptionLocalDataSourceRef ref) {
  return PrescriptionLocalDataSource();
}

@riverpod
PrescriptionRepository prescriptionRepository(PrescriptionRepositoryRef ref) {
  return PrescriptionRepositoryImpl(
    remoteDataSource: ref.watch(aiRemoteDataSourceProvider),
    localDataSource: ref.watch(prescriptionLocalDataSourceProvider),
  );
}
