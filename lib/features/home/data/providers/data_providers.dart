import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumpyo_app/features/home/data/datasources/ai_remote_datasource.dart';
import 'package:sumpyo_app/features/home/data/datasources/prescription_local_datasource.dart';
import 'package:sumpyo_app/features/home/data/repositories/prescription_repository_impl.dart';
import 'package:sumpyo_app/features/home/domain/repositories/prescription_repository.dart';

final aiRemoteDataSourceProvider = Provider<AIRemoteDataSource>((ref) {
  return AIRemoteDataSource();
});

final prescriptionLocalDataSourceProvider = Provider<PrescriptionLocalDataSource>((ref) {
  return PrescriptionLocalDataSource();
});

final prescriptionRepositoryProvider = Provider<PrescriptionRepository>((ref) {
  return PrescriptionRepositoryImpl(
    remoteDataSource: ref.watch(aiRemoteDataSourceProvider),
    localDataSource: ref.watch(prescriptionLocalDataSourceProvider),
  );
});
