import "dart:convert";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:google_generative_ai/google_generative_ai.dart";
import "package:sumpyo_app/features/home/data/datasources/ai_remote_datasource.dart";

// We don't use 'implements' because GenerativeModel and GenerateContentResponse are final classes.
// Instead, we use dynamic in AIRemoteDataSource to allow these mocks to be used.
class MockGenerativeModel extends Mock {
  Future<dynamic> generateContent(Iterable<dynamic> prompt) =>
      super.noSuchMethod(Invocation.method(#generateContent, [prompt]));
}

class MockGenerateContentResponse extends Mock {
  String? get text => super.noSuchMethod(Invocation.getter(#text));
}

void main() {
  late AIRemoteDataSource dataSource;
  late MockGenerativeModel mockModel;
  late MockGenerateContentResponse mockResponse;

  setUpAll(() {
    registerFallbackValue([Content.text('')]);
  });

  setUp(() {
    mockModel = MockGenerativeModel();
    mockResponse = MockGenerateContentResponse();
    dataSource = AIRemoteDataSource(model: mockModel);
  });

  group("AIRemoteDataSource", () {
    const tEmotion = "오늘 하루가 너무 힘들었어요";
    const tStyle = "F";
    final tPrescriptionMap = {
      "title": "마음의 휴식",
      "content": "정말 고생 많으셨어요. 당신의 노력을 알아주는 이가 여기 있습니다.",
      "quote": "가장 어두운 밤도 결국 아침을 맞이합니다."
    };

    test("generatePrescription returns expected JSON data when successful",
        () async {
      // arrange
      when(() => mockResponse.text).thenReturn(jsonEncode(tPrescriptionMap));
      when(() => mockModel.generateContent(any()))
          .thenAnswer((_) async => mockResponse);

      // act
      final result = await dataSource.generatePrescription(
        emotion: tEmotion,
        style: tStyle,
      );

      // assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result["title"], tPrescriptionMap["title"]);
      expect(result["content"], tPrescriptionMap["content"]);
      expect(result["quote"], tPrescriptionMap["quote"]);
      verify(() => mockModel.generateContent(any())).called(1);
    });

    test("generatePrescription handles markdown JSON formatting in response",
        () async {
      // arrange
      final markdownJson = "```json\n${jsonEncode(tPrescriptionMap)}\n```";
      when(() => mockResponse.text).thenReturn(markdownJson);
      when(() => mockModel.generateContent(any()))
          .thenAnswer((_) async => mockResponse);

      // act
      final result = await dataSource.generatePrescription(
        emotion: tEmotion,
        style: tStyle,
      );

      // assert
      expect(result, tPrescriptionMap);
    });

    test("generatePrescription returns fallback when AI returns empty response",
        () async {
      // arrange
      when(() => mockResponse.text).thenReturn(null);
      when(() => mockModel.generateContent(any()))
          .thenAnswer((_) async => mockResponse);

      // act
      final result = await dataSource.generatePrescription(
        emotion: tEmotion,
        style: tStyle,
      );

      // assert
      expect(result["title"], "잠시 쉬어가는 시간의 약");
      expect(result["content"], contains("문제가 생겨"));
      expect(result["quote"], contains("충분히 잘 해내고"));
    });

    test(
        "generatePrescription returns fallback when exception occurs during generation",
        () async {
      // arrange
      when(() => mockModel.generateContent(any()))
          .thenThrow(Exception("Network error"));

      // act
      final result = await dataSource.generatePrescription(
        emotion: tEmotion,
        style: tStyle,
      );

      // assert
      expect(result["title"], "잠시 쉬어가는 시간의 약");
    });

    test("handles all styles correctly without crashing", () async {
      final styles = ["F", "T", "W", "INVALID"];

      for (final style in styles) {
        // arrange
        when(() => mockResponse.text).thenReturn(jsonEncode(tPrescriptionMap));
        when(() => mockModel.generateContent(any()))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await dataSource.generatePrescription(
          emotion: tEmotion,
          style: style,
        );

        // assert
        expect(result, tPrescriptionMap);
      }
    });
  });
}
