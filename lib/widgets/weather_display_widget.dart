import 'package:flutter/material.dart';
import '../models/weather_data.dart';

class WeatherDisplayWidget extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherDisplayWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildWeatherCard(
          'Temperature',
          '${weatherData.temperature}°C',
          'Feels like ${weatherData.feelsLike}°C',
          Icons.thermostat,
          Colors.orange,
        ),
        _buildWeatherCard(
          'Humidity',
          '${weatherData.humidity}%',
          'Comfortable',
          Icons.water_drop,
          Colors.blue,
        ),
        _buildWeatherCard(
          'Wind',
          '${weatherData.windSpeed} mph',
          'From ${weatherData.windDirection}',
          Icons.air,
          Colors.teal,
        ),
        _buildWeatherCard(
          'Visibility',
          '${weatherData.visibility} km',
          'Excellent',
          Icons.visibility,
          Colors.indigo,
        ),
        _buildWeatherCard(
          'UV Index',
          '${weatherData.uvIndex}',
          'Moderate',
          Icons.wb_sunny,
          Colors.amber,
        ),
        _buildWeatherCard(
          'Pressure',
          '${weatherData.pressure}',
          'hPa',
          Icons.speed,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildWeatherCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}