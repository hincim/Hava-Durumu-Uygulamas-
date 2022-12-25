import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "7b6ad88d11b66abc57257ca4417fe2a7";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  LocationHelper locationData;

  WeatherData({required this.locationData});

  late double currentTemperature;
  late int currentCondition;
  late String city;

  Future<void> getCurrentTemperature() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&unit=metric");
    Response response = await get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather["main"]["temp"];
        currentCondition = currentWeather["weather"][0]["id"];
        city = currentWeather["name"];
      } catch (e) {
        print(e);
      }
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon:
              Icon(FontAwesomeIcons.cloud, size: 75.0, color: Colors.white),
          weatherImage: AssetImage("assets/bulutlu.png"));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        // saat akşamsa
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.moon, size: 75.0, color: Colors.white),
            weatherImage: AssetImage("assets/gece.png"));
      } else {
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.sun, size: 75.0, color: Colors.white),
            weatherImage: AssetImage("assets/gunesli.png"));
      }
    }
  }
}
