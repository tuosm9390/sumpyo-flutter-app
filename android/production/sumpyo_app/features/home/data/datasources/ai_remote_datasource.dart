import "dart:convert";
import "package:dio/dio.dart";
import "../models/prescription_model.dart";

class AIRemoteDataSource {
  final Dio dio;
  static const String _apiKey = "YOUR_GEMINI_API_KEY"; // Should be managed securely
  static const String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

  AIRemoteDataSource(this.dio);

  Future<PrescriptionModel> generatePrescription(String prompt, String style) async {
    final systemInstruction = _getSystemPrompt(style);
    
    final response = await dio.post(
      "$_baseUrl?key=$_apiKey",
      data: {
        "contents": [
          {
            "parts": [
              {"text": "사용자의 고민: $prompt"}
            ]
          }
        ],
        "systemInstruction": {
          "parts": [
            {"text": systemInstruction}
          ]
        },
        "generationConfig": {
          "responseMimeType": "application/json",
        }
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final text = data["candidates"][0]["content"]["parts"][0]["text"];
      final json = jsonDecode(text);
      return PrescriptionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: json["title"] ?? "따뜻한 처방전",
        content: json["content"] ?? "마음이 편안해지길 바랍니다.",
        quote: json["quote"] ?? "잠시 쉬어가도 괜찮아요.",
      );
    } else {
      throw Exception("Failed to generate prescription");
    }
  }

  String _getSystemPrompt(String style) {
    String styleDesc = "";
    switch (style) {
      case "F":
        styleDesc = "마음을 어루만지는 따뜻한 위로와 정서적 지지의 말투 (공감형)";
        break;
      case "T":
        styleDesc = "냉철하지만 현실적인 해결책과 객관적 상황 분석의 말투 (이성형)";
        break;
      case "W":
        styleDesc = "포근한 격려와 아날로그적인 감성, 시적인 표현의 말투 (온기형)";
        break;
      default:
        styleDesc = "다정한 약사의 말투";
    }

    return "당신은 심야의 AI 약사입니다. 사용자의 고민을 듣고, 마음을 어루만지는 처방전 제목, 상세 처방 내용, 그리고 위로가 되는 한 줄 명언(quote)을 작성해 주세요.\n"
        "스타일: $styleDesc\n"
        "응답은 반드시 다음 JSON 형식을 따라야 합니다: { \"title\": \"...\", \"content\": \"...\", \"quote\": \"...\" }\n"
        "은유적인 제목을 사용하고, 기계적인 말투를 배제하세요.";
  }
}
