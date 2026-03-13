import '../../domain/entities/prescription.dart';
import '../../domain/repositories/prescription_repository.dart';
import '../datasources/ai_remote_datasource.dart';
import '../datasources/prescription_local_datasource.dart';
import '../models/prescription_model.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final AIRemoteDataSource remoteDataSource;
  final PrescriptionLocalDataSource localDataSource;

  PrescriptionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Prescription> generatePrescription(
      String emotion, String style) async {
    // 1. API 호출
    final aiResponse = await remoteDataSource.generatePrescription(
      emotion: emotion,
      style: style,
    );

    // 2. 모델 매핑 (emotion 필드 포함) 및 로컬 저장
    final prescriptionModel = PrescriptionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      style: style,
      title: (aiResponse['title'] as String?) ?? "",
      content: (aiResponse['content'] as String?) ?? "",
      quote: (aiResponse['quote'] as String?) ?? "",
      emotion: emotion, // 사용자가 입력한 원래의 고민 내용 추가
    );

    await localDataSource.cachePrescription(prescriptionModel);

    return prescriptionModel.toEntity();
  }

  @override
  Future<List<Prescription>> getPrescriptions() async {
    final models = await localDataSource.getCachedPrescriptions();
    return models.map((m) => m.toEntity()).toList();
  }
}
