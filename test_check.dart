import "package:google_generative_ai/google_generative_ai.dart";
import "package:http/http.dart" as http;
void main() {
  GenerativeModel(
    model: "test",
    apiKey: "test",
    httpClient: http.Client(),
  );
}
