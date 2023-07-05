import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';

void main() {
  runApp(MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS HENDRA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String namaKota = "Tangerang Selatan";
  int temperature = 0;
  int maxTemperature = 0;
  int minTemperature = 0;
  String deskripsiCuaca = "";
  String date = "";

  Future<void> getWeatherData() async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$namaKota&appid=3f0dcc126042102cb813207db3fce0c5&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final formattedDate =
          DateFormat('EEEE, MMMM d, y').format(DateTime.now());
      setState(() {
        temperature = data['main']['temp'].toInt();
        maxTemperature = data['main']['temp_max'].toInt();
        minTemperature = data['main']['temp_min'].toInt();
        deskripsiCuaca = data['weather'][0]['main'];
        date = formattedDate;
      });
    } else {
      throw Exception('Gagal memuat data cuaca');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ayangjiso.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                namaKota,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'SwanseaBold'),
              ),
              SizedBox(height: 30),
              Text(
                '$date',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SwanseaBold',
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(height: 20),
              Text(
                '$temperature°C',
                style: TextStyle(
                    fontSize: 150,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'SwanseaBold'),
              ),
              SizedBox(height: 0),
              Text(
                '---------',
                style: TextStyle(fontSize: 100, color: Colors.white),
              ),
              SizedBox(height: 15),
              Text(
                deskripsiCuaca,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SwanseaBold'),
              ),
              SizedBox(height: 8),
              Text(
                '$maxTemperature°C / $minTemperature°C',
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'SwanseaBolds',
                    color: const Color.fromARGB(255, 228, 224, 224)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
