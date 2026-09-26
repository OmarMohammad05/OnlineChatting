import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/weather_data.dart';
import '../widgets/comfort_index_widget.dart';
import '../widgets/weather_display_widget.dart';

class ResultsScreen extends StatelessWidget {
  final WeatherData weatherData;
  final VoidCallback onNewSearch;

  const ResultsScreen({
    super.key,
    required this.weatherData,
    required this.onNewSearch,
  });

  String _getComfortStatus(int score) {
    if (score >= 80) return "Excellent";
    if (score >= 60) return "Good";
    if (score >= 40) return "Fair";
    return "Poor";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onNewSearch,
                icon: const Icon(Icons.arrow_back),
                label: const Text('New Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  foregroundColor: Colors.black87,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _shareResults(),
                icon: const Icon(Icons.share),
                tooltip: 'Share Results',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Comfort Index Card
          ComfortIndexWidget(
            score: weatherData.comfortIndex,
            status: _getComfortStatus(weatherData.comfortIndex),
          ),
          const SizedBox(height: 16),

          // Weather Details
          WeatherDisplayWidget(weatherData: weatherData),
          const SizedBox(height: 16),

          // Recommendations Card
          _buildRecommendationsCard(),
          const SizedBox(height: 16),

          // Alternative Times Card
          _buildAlternativeTimesCard(),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Recommendations for Travel',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...weatherData.recommendations.asMap().entries.map((entry) {
              final index = entry.key;
              final recommendation = entry.value;
              final parts = recommendation.split(' - ');
              final title = parts[0];
              final description = parts.length > 1 ? parts[1] : '';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: index == 0 
                      ? Colors.green.withOpacity(0.1)
                      : index == 1
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: index == 0 
                        ? Colors.green.withOpacity(0.3)
                        : index == 1
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0 ? '👍' : index == 1 ? 'ℹ️' : '☂️',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          if (description.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeTimesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.access_time, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Alternative Times',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: weatherData.alternativeTimes.map((alt) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        alt.time,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        alt.date.toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${alt.comfortIndex}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        _getComfortStatus(alt.comfortIndex),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _shareResults() {
    final shareText = '''
Weather Comfort Results

Comfort Index: ${weatherData.comfortIndex}/100 (${_getComfortStatus(weatherData.comfortIndex)})
Temperature: ${weatherData.temperature}°C (feels like ${weatherData.feelsLike}°C)
Humidity: ${weatherData.humidity}%
Wind: ${weatherData.windSpeed} mph ${weatherData.windDirection}

Top Recommendation: ${weatherData.recommendations.first}

Generated by Weather Comfort App
    ''';
    
    Share.share(shareText);
  }
}