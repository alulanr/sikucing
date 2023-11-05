import 'dart:convert';
import '../models/m_openai.dart';
import 'package:http/http.dart' as http;

class AboutCatService {
  final String apiKey;
  final String baseUrl = 'https://api.openai.com/v1/completions';

  AboutCatService(this.apiKey);

  Future<List<AboutCatModel>> getAboutCats({
    required String cat,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'model': 'text-davinci-003',
        'temperature': 0.4,
        'prompt': '$cat',
        'max_tokens': 50,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final aboutCats = data['choices'] as List;
      return aboutCats.map((rec) {
        return AboutCatModel.fromJson({
          'title': 'Cat About',
          'description': rec['text'],
        });
      }).toList();
    } else {
      throw Exception('Failed to load AI');
    }
  }
}
