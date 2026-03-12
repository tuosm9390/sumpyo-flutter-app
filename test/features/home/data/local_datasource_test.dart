import "dart:io";
import "package:flutter_test/flutter_test.dart";
import "package:hive/hive.dart";
import "package:sumpyo_app/features/home/data/datasources/prescription_local_datasource.dart";
import "package:sumpyo_app/features/home/data/models/prescription_model.dart";

void main() {
  late PrescriptionLocalDataSource dataSource;
  final tempDir = Directory.systemTemp.createTempSync();

  setUp(() async {
    Hive.init(tempDir.path);
    dataSource = PrescriptionLocalDataSource();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test("cachePrescription and getCachedPrescriptions work correctly", () async {
    const prescription = PrescriptionModel(
      id: "1",
      title: "Title",
      content: "Content",
      quote: "Quote",
    );

    await dataSource.cachePrescription(prescription);
    final cached = await dataSource.getCachedPrescriptions();

    expect(cached.length, 1);
    expect(cached.first.id, "1");
    expect(cached.first.title, "Title");
  });
}
