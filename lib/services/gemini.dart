import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiInstance {

  GeminiInstance._();
  static final GeminiInstance shared = GeminiInstance._();

  factory GeminiInstance() {
    return shared;
  }

  final _geminiInstance = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: '', // TODO: Add Gemini API Key
  );

  GenerativeModel get geminiInit => _geminiInstance;

  Future<GenerateContentResponse> getPokemonTextInfo(String prompt) async {
    final response = await _geminiInstance.generateContent(
        [
          Content.text(prompt),
        ]
    );
    return response;
  }

  Future<GenerateContentResponse> getPokemonInfo(String prompt, Uint8List image, String mimeType) async {
    final response = await _geminiInstance.generateContent(
      [
        Content.text(prompt),
        Content.data(mimeType, image),
      ]
    );
    return response;
  }

}
