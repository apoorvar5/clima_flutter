import 'package:climaweather/services/networking.dart';
import 'package:climaweather/services/location.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String typedName) async{
    NetworkHelper networkHelper=NetworkHelper(url: "https://api.openweathermap.org/data/2.5/weather?q=$typedName&appid=3307e67575e2cdcfc23da18d3cdbf644&units=metric");
    var weatherData= await networkHelper.getData();
    return weatherData;
  }
  Future<dynamic> getWeatherData() async{
    Location location= Location();
    await location.getCurrentPosition();
    NetworkHelper networkHelper=NetworkHelper(url: "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=3307e67575e2cdcfc23da18d3cdbf644&units=metric");
    var weatherData= await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
