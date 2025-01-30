import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey: openWeatherAPIKey);
  Weather? _weather;
  final _searchController = TextEditingController();

  _fetchWeather(String? city) async {
    String cityName = city ?? await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'drizzle':
      case 'rain':
        return 'assets/rainy.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
      case 'mist':
        return 'assets/cloudy.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
            'Weather App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 26,
                  color: Colors.grey[700],
                ),
                Text(
                  _weather?.cityName ?? "loading city...",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            Text(
              '${_weather?.temperature.round()}°C',
              style: TextStyle(fontSize: 26,color: Colors.grey[700],),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(fontSize: 22,color: Colors.grey[700],),
            ),
          ],
        ),
      ),
    );
  }
}
