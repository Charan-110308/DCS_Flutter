import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

class ApiService {
  static Future<List<dynamic>> searchMovies(String query) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
