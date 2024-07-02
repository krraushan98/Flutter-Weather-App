import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/weatherData.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cityController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    void loadWeatherData(String city) async {
      final weatherModel = Provider.of<weatherData>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      try {
        int code = await weatherModel.getWeatherData(city);
        if (code == 200) {
          Navigator.pushNamed(context, '/weatherDetails');
        }else if (code == 404) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('City not found'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error fetching weather data'),
              duration: Duration(seconds: 2),
            ),
          );
        } 
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching weather data: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(children: [
            Image.asset(
              'assests/2.png',
              height: height * 0.95,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: height * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: 'Enter City Name',
                        prefixIcon: Icon(Icons.search, color: Colors.teal[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.65),
                  ElevatedButton(
                    onPressed: () {
                      if (cityController.text.isNotEmpty) {
                        loadWeatherData(cityController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a city name'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal[400],
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 40.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ), 
                      elevation: 5,
                    ),
                    child: const Text(
                      'Get Weather Details',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                height: height,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
