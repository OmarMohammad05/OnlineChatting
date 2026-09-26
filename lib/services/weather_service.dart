import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_request.dart';
import '../models/weather_response.dart';

class WeatherService {
  static const String baseUrl = 'http://localhost:5000';

  Future<WeatherResponse> getWeatherForecast(WeatherRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/weather/forecast'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return WeatherResponse.fromJson(responseData);
    } catch (e) {
      return WeatherResponse(
        success: false,
        message: 'Failed to get weather forecast: ${e.toString()}',
      );
    }
  }
}