import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  NetworkHelper({required this.url});
  final String url;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      //String city=jsonDecode(data)['name'];
      //print(city);
      //THIS IS TO CHECK IF IT IS PRINTING DATA FROM OpenWeatherApp.
      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
}