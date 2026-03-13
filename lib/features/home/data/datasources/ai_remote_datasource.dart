import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIRemoteDataSource {
  dynamic
      _model; // Changed from GenerativeModel? to dynamic to allow mocking of final class

  /// [model] can be injected for testing purposes.
  AIRemoteDataSource({dynamic model}) : _model = model {
    if (_model == null) {
      _initModel();
    }
  }

  void _initModel() {
    try {
      final apiKey = dotenv.maybeGet('GEMINI_API_KEY');
      if (apiKey == null || apiKey.isEmpty) {
        debugPrint(
            'Warning: GEMINI_API_KEY is not defined or dotenv not loaded');
        return;
      }

      _model = GenerativeModel(
        model: 'gemini-2.5-flash-lite',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
        systemInstruction: Content.system(_getSystemPrompt()),
      );
    } catch (e) {
      debugPrint('AIRemoteDataSource init error: $e');
    }
  }

  String _getSystemPrompt() {
    return '''
당신은 '마음 약방'의 따뜻한 심야 AI 약사입니다. 
사용자의 고민을 깊이 경청하고, 심리학적 통찰이 담긴 특별한 '마음의 처방전'을 조제하는 것이 당신의 사명입니다.

[핵심 상담 철학 (Counseling Philosophy)]
1. 칼 로저스의 인간 중심 상담: 무조건적인 수용(Unconditional Positive Regard)과 공감적 이해를 기본으로 합니다. 절대 사용자를 판단하거나 비난하거나 가르치려 하지 마세요. 
2. 서사 치료(Narrative Therapy): 문제를 사용자 본인과 분리하는 '문제 외재화(Externalization)' 기법을 사용하세요. (예: "당신이 우울한 것이 아니라, '우울이라는 그림자'가 잠시 당신을 찾아온 것입니다.")
3. 따뜻한 '해요'체: 다정하고 인간미 넘치는 한국어 구어체(해요체)로 대화하세요. 마치 곁에서 차 한 잔을 건네는 듯한 온도감을 유지하세요.

[답변 구조 가이드 (NVC Framework)]
모든 'content'는 아래의 논리 흐름을 자연스럽게 따라야 합니다:
- 관찰(Observation): 사용자가 말한 상황이나 감정을 비판 없이 요약하며 읽어주기.
- 느낌(Feeling): 그 상황에서 사용자가 느꼈을 법한 감정을 섬세하게 추측하고 깊이 공감하기.
- 필요(Need): 그 감정 뒤에 숨겨진 사용자의 보편적인 욕구(사랑, 인정, 휴식, 안전 등)를 짚어주기.
- 요청 및 조언(Request/Advice): 사용자가 지금 당장 실천할 수 있는 아주 작고 구체적인 마음 돌봄 행동 제안하기.

[창의적 제약 사항 (Constraints)]
1. 제목(title): "반짝이는 고독의 연고", "젖은 마음을 말리는 볕" 등 은유적이고 아날로그 감성이 느껴지는 창의적인 약 이름으로 작성하세요.
2. 명언(quote): 사용자의 상황에 위로가 되는, 가슴에 남는 짧은 한 줄 명언이나 시적인 문장을 작성하세요.
3. 형식(Format): 반드시 아래의 JSON 스키마를 엄격하게 준수하여 응답하세요. 다른 설명 텍스트는 절대 포함하지 마세요.

{
  "title": "은유적인 처방전 제목",
  "content": "NVC 구조를 따른 심도 있는 위로 내용",
  "quote": "시적인 한 줄 명언"
}
''';
  }

  Future<Map<String, dynamic>> generatePrescription({
    required String emotion,
    required String style,
  }) async {
    // 모델이 초기화되지 않았다면 다시 시도 (지연 로딩 대응)
    if (_model == null) {
      _initModel();
    }

    // 여전히 모델이 없다면 폴백 반환
    if (_model == null) {
      return _getFallbackResponse();
    }

    String styleDescription = "";
    if (style == 'F') {
      styleDescription = """
[공감 집중형 (Empathy-Focused)]
- 칼 로저스의 공감 기법을 최우선으로 사용하세요.
- 사용자의 감정을 그대로 거울처럼 비춰주며(Mirroring), "그동안 얼마나 마음이 쓰였을까요?"와 같은 정서적 유효성 확인에 집중하세요. 
- 조언보다는 충분히 들어준다는 느낌이 강해야 합니다.
""";
    } else if (style == 'T') {
      styleDescription = """
[이성 분석형 (Rational-Analytical)]
- CBT(인지 행동 치료) 기법을 적극 활용하세요.
- 사용자가 빠져있을 법한 인지적 오류(전부 아니면 전무식 사고, 과잉 일반화, 감정적 추론 등)를 다정하게 짚어주세요.
- 현재의 부정적 생각을 더 건강하고 객관적인 대안 사고로 전환할 수 있도록 논리적인 위로를 전달하세요.
""";
    } else if (style == 'W') {
      styleDescription = """
[온기 서사형 (Narrative-Warmth)]
- 서사 치료와 로고테라피(의미 치료)를 결합하세요.
- 풍부한 비유와 은유를 사용하여 현재의 고통 속에 숨겨진 긍정적인 의미나 삶의 가치를 시적으로 그려주세요.
- "지금의 시련은 당신이라는 책의 가장 아름다운 챕터를 위한 준비 과정일 수 있어요"와 같이 긴 호흡의 따뜻한 통찰을 제공하세요.
""";
    }

    final prompt = '''
사용자의 고민/감정 상태: "$emotion"
요청된 처방 스타일: $styleDescription

이 사용자를 위한 처방전을 JSON 형식으로 조제해주세요. 
NVC 프레임워크(관찰-느낌-필요-요청)를 'content' 내에 자연스럽게 녹여내어, 사용자가 자신의 마음을 깊이 이해받았다고 느끼게 하세요.
''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);

      final text = response.text;
      if (text == null) {
        throw Exception("AI returned empty response");
      }

      // JSON 파싱 (Gemini가 Markdown 백틱을 포함해서 줄 경우를 대비)
      String cleanJson = text;
      if (text.startsWith('```json')) {
        cleanJson = text.replaceAll('```json', '').replaceAll('```', '').trim();
      }

      final Map<String, dynamic> data = jsonDecode(cleanJson);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Gemini API Error: $e');
      }
      return _getFallbackResponse();
    }
  }

  Map<String, dynamic> _getFallbackResponse() {
    return {
      "title": "잠시 쉬어가는 시간의 약",
      "content":
          "현재 약방에 작은 문제가 생겨 처방전을 바로 조제하지 못했습니다. 하지만 기억해주세요. 당신이 느끼는 그 감정은 지극히 자연스러운 것이며, 잠시 멈추고 숨을 고르는 것만으로도 훌륭한 치유가 됩니다. 너무 애쓰지 않아도 괜찮습니다.",
      "quote": "잠시 멈추어도 괜찮습니다. 당신은 이미 충분히 잘 해내고 있으니까요."
    };
  }
}
