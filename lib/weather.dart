import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({required this.cityName, required this.temperature, required this.description});
}

Future<Weather> fetchWeather(String cityName) async {
  final apiKey = '0b997a615c8f0127db85d74a0305faec'; // Replace with your OpenWeatherMap API key
  final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final String name = data['name'];
    final double temp = data['main']['temp'];
    final String desc = data['weather'][0]['description'];

    return Weather(cityName: name, temperature: temp, description: desc);
  } else {
    throw Exception('Failed to load weather data');
  }
}

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({required this.weather});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onSubmitted: (value) {
                    _searchCity(context, value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter City Name',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Color(hashCode.),),
                ),
                onPressed: () async {
                  final weatherData = await fetchWeather('Mumbai');
                  _showWeatherDialog(context, weatherData);
                },
                child: Text('Fetch Default Weather'),
              ),
              SizedBox(height: 20),
              Text(
                'City: ${weather.cityName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Temperature: ${weather.temperature}°C',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Description: ${weather.description}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchCity(BuildContext context, String cityName) async {
    try {
      final weatherData = await fetchWeather(cityName);
      _showWeatherDialog(context, weatherData);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showWeatherDialog(BuildContext context, Weather weatherData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Weather for ${weatherData.cityName}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Temperature: ${weatherData.temperature}°C'),
              Text('Description: ${weatherData.description}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

