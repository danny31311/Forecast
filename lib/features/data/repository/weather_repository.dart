import 'dart:convert';
import 'package:weather_application_2/features/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather(String cityName);
}

class WeatherRepo implements WeatherRepository {
  @override
  Future<WeatherModel> fetchWeather(String cityName) async {
     final parameters = {
      'appid': '254c9c65adc2f48f757587f78aae369f', // апиКей 
      'q': cityName, // название города
      'cnt': '24', // 24 - ограничение на получение данных. Из доки API
      'units': 'metric', // перевожу в нужный формат
    };

    final uri = Uri.https('api.openweathermap.org', '/data/2.5/forecast/', parameters); // формирование запроса
    final response = await http.get(uri);
    
    if (response.statusCode == 200) { // положительный ответ от сервера
      return WeatherModel.fromJson(json.decode(response.body)); // десериализую json
    } else {
      throw Exception('Error'); // иначе прокидываю ошибку
    }
  }
}







