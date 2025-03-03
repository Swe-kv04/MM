import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  final Dio _dio = Dio();
  String? city;
  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchWeather(String city) async {
    const String apiKey = '41df9e159c227e36db458df0a84dff08';
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await _dio.get(url);
      setState(() {
        weatherData = response.data;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch weather. Please try again!';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      fetchWeather(_controller.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (errorMessage.isNotEmpty)
              Text(errorMessage, style: TextStyle(color: Colors.red))
            else if (weatherData != null)
              Column(
                children: [
                  Text(
                    '${weatherData!['name']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text('${weatherData!['main']['temp']}°C',
                      style: TextStyle(fontSize: 20)),
                  Text('${weatherData!['weather'][0]['description']}'),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
//dio: ^5.0.0  in pubspec.yaml under dependencies

//flutter  pub get do in terminal
