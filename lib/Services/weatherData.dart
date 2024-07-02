import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class weatherData with ChangeNotifier {
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  Future<int> getWeatherData(String cityName) async {
    notifyListeners();

    try {
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=d1094e4fa62d11fe1d7d4582fa6a595f&units=metric');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _data = convert.jsonDecode(response.body);
      } else {
        _data = {};
      }
      return response.statusCode;
    } catch (e) {
      _data = {};
    }

    notifyListeners();
    return 500;
  }
}
