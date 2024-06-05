class Urls {
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5';
  static const String apiKey = '7e3b3ec3de40613401c1de6819b8aa5c';

  static String currentWeatherByName(String city) => '$baseUrl/weather?q=$city&appid=$apiKey';

  static String weatherIcon(String iconCode) => 'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
