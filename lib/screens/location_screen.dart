import 'package:climaweather/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:climaweather/utilities/constants.dart';
import 'package:climaweather/services/weather.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationData});
  final locationData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp=0;
  int condition=0;
  String city='';
  String weatherIcon='';
  String weatherMessage='';
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationData);
  }
  void updateUI(dynamic weatherData){
    setState((){
      if(weatherData==null){
        temp=0;
        weatherIcon='?';
        weatherMessage='Unable to retrieve data';
        return;
      }
      temp= weatherData['main']['temp'];
      condition=weatherData['weather'][0]['id'];
      city=weatherData['name'];
      weatherIcon=WeatherModel().getWeatherIcon(condition);
      weatherMessage=WeatherModel().getMessage(temp.toInt());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData=await WeatherModel().getWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName =await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print(typedName);
                      if(typedName != null){
                        updateUI(await WeatherModel().getCityWeather(typedName));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${temp.round()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $city!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}