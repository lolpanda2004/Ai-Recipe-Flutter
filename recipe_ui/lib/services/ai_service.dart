import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  static const String _endpoint =
      "https://api.groq.com/openai/v1/chat/completions";
  static const String _model = "llama-3.3-70b-versatile";

  static Future<String> getRecipe(String userPrompt) async {
    final String _apiKey = dotenv.env['GROQ_API_KEY'] ?? '';

    if (_apiKey.isEmpty) {
      throw Exception("Missing GROQ_API_KEY in .env");
    }

    final url = Uri.parse(_endpoint);

    final body = jsonEncode({
      "model": _model,
      "messages": [
        {"role": "user", "content": userPrompt},
      ],
    });

    final resp = await http
        .post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $_apiKey",
          },
          body: body,
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw Exception("Request to Groq API timed out ⏱️");
          },
        );

    if (resp.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(resp.body);
      if (data["choices"] != null &&
          data["choices"].isNotEmpty &&
          data["choices"][0]["message"]?["content"] != null) {
        return data["choices"][0]["message"]["content"] as String;
      } else {
        throw Exception("Invalid response format from Groq: ${resp.body}");
      }
    } else {
      throw Exception("Groq API error: ${resp.statusCode} — ${resp.body}");
    }
  }
}
