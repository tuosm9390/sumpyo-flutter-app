import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/prescription_model.dart';

class PrescriptionLocalDataSource {
  static const String _fileName = 'data.json';

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> cachePrescription(PrescriptionModel prescription) async {
    final file = await _getFile();
    List<PrescriptionModel> prescriptions = [];

    if (await file.exists()) {
      final String contents = await file.readAsString();
      if (contents.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(contents);
        prescriptions = jsonList
            .map(
                (e) => PrescriptionModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }

    prescriptions.add(prescription);

    final List<Map<String, dynamic>> jsonList =
        prescriptions.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<List<PrescriptionModel>> getCachedPrescriptions() async {
    final file = await _getFile();

    if (await file.exists()) {
      final String contents = await file.readAsString();
      if (contents.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(contents);
        return jsonList
            .map(
                (e) => PrescriptionModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }

    return [];
  }
}
