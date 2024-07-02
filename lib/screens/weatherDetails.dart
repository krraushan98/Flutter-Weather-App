import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatheapp/Services/weatherData.dart';

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({super.key});

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var width = mediaQuery.size.width;

    var weatherModel = Provider.of<weatherData>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 126, 200, 194),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  SizedBox(height: height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        weatherModel.data['name'] ?? 'City Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  Container(
                    height: height * 0.2,
                    width: width * 0.6,
                    child: Image.network(
                      'https://openweathermap.org/img/w/${weatherModel.data['weather'][0]['icon']}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weatherModel.data['main']['temp']} °C' ,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Feels like  ${weatherModel.data['main']['feels_like']} °C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weatherModel.data['weather'][0]['main']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30 ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  const Divider(),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.air, color: Colors.white),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            '${weatherModel.data['wind']['speed']} km/h',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Wind Speed',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.cloud, color: Colors.white),
                      const SizedBox(width: 15),
                      Column(
                        children: [
                          Text(
                            weatherModel.data['weather'] != null
                                ? weatherModel.data['weather'][0]['description']
                                : 'Weather',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Weather',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    children: [
                      const Icon(Icons.water, color: Colors.white),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            '${weatherModel.data['main']['humidity']} %',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Humidity',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.thermostat, color: Colors.white),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            '${weatherModel.data['main']['pressure']} hPa',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Pressure',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  //Refresh Button
                  ElevatedButton(
                    onPressed: () async {
                      await weatherModel.getWeatherData(weatherModel.data['name']);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal[400],
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 40.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Refresh',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
