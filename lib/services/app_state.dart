import 'package:flutter/foundation.dart';
import '../models/weather_data.dart';
import '../models/weather_request.dart';
import 'weather_service.dart';

class AppState extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _error;

  WeatherData? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getWeatherForecast(WeatherRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _weatherService.getWeatherForecast(request);
      
      if (response.success && response.data != null) {
        _weatherData = response.data;
      } else {
        _error = response.message ?? 'Failed to get weather forecast';
      }
    } catch (e) {
      _error = 'Failed to get weather forecast: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearWeatherData() {
    _weatherData = null;
    _error = null;
    notifyListeners();
  }
}