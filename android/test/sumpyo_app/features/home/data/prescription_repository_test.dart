import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:sumpyo_app/features/home/data/repositories/prescription_repository_impl.dart";
import "package:sumpyo_app/features/home/domain/entities/prescription.dart";
import "package:sumpyo_app/features/home/data/datasources/ai_remote_datasource.dart";
import "package:sumpyo_app/features/home/data/datasources/prescription_local_datasource.dart";
import "package:sumpyo_app/features/home/data/models/prescription_model.dart";

class MockAIRemoteDataSource extends Mock implements AIRemoteDataSource {}
class MockPrescriptionLocalDataSource extends Mock implements PrescriptionLocalDataSource {}
class FakePrescriptionModel extends Fake implements PrescriptionModel {}

void main() {
  late PrescriptionRepositoryImpl repo;
  late MockAIRemoteDataSource mockRemote;
  late MockPrescriptionLocalDataSource mockLocal;

  setUpAll(() {
    registerFallbackValue(FakePrescriptionModel());
  });

  setUp(() {
    mockRemote = MockAIRemoteDataSource();
    mockLocal = MockPrescriptionLocalDataSource();
    repo = PrescriptionRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  test("getPrescriptions returns a list of prescriptions from local cache", () async {
    final mockModels = [
      const PrescriptionModel(id: "1", title: "T1", content: "C1", quote: "Q1")
    ];
    when(() => mockLocal.getCachedPrescriptions()).thenAnswer((_) async => mockModels);

    final result = await repo.getPrescriptions();
    expect(result, isNotEmpty);
    expect(result.first.id, "1");
  });

  test("generatePrescription calls remote, caches locally, and returns entity", () async {
    const mockModel = PrescriptionModel(id: "1", title: "T", content: "C", quote: "Q");
    
    when(() => mockRemote.generatePrescription(any(), any())).thenAnswer((_) async => mockModel);
    when(() => mockLocal.cachePrescription(any())).thenAnswer((_) async {});

    final result = await repo.generatePrescription("test", "style");
    
    expect(result, isA<Prescription>());
    expect(result.id, "1");
    verify(() => mockRemote.generatePrescription("test", "style")).called(1);
    verify(() => mockLocal.cachePrescription(any())).called(1);
  });
}
