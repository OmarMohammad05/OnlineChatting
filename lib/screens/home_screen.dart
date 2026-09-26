import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../widgets/weather_form.dart';
import 'results_screen.dart';
import 'loading_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.wb_sunny, color: Colors.white),
            SizedBox(width: 8),
            Text('Weather Comfort'),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.isLoading) {
            return const LoadingScreen();
          }

          if (appState.weatherData != null) {
            return ResultsScreen(
              weatherData: appState.weatherData!,
              onNewSearch: () => appState.clearWeatherData(),
            );
          }

          return const SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: WeatherForm(),
          );
        },
      ),
    );
  }
}