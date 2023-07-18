import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/fore_cast_card.dart';
import 'package:weather_app/features/home_page_screen/home_page_screen.dart';
import 'package:weather_app/providers/weather_provider.dart';

class LiveWeather extends StatefulWidget {
  static const routeName = '/live-weather';

  const LiveWeather({super.key});

  @override
  State<LiveWeather> createState() => _LiveWeatherState();
}

class _LiveWeatherState extends State<LiveWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomePageScreen.routeName);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff7c4dff),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Consumer<WeatherProvider>(
        builder: (context, value, _) {
          final currentWeather = value.currentWeather;
          if (currentWeather != null) {
            final DateTime now = DateTime.now();

            final DateFormat dayFormat = DateFormat('EEEE');
            final String day = dayFormat.format(now);

            final DateFormat timeFormat = DateFormat('jm');
            final String time = timeFormat.format(now);

            final upcomingHours =
                currentWeather.forecast.forecastday[0].hour.where(
              (hour) => hour.time.isAfter(now),
            );

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${currentWeather.location.country}, ${currentWeather.location.name}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$day, $time',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        height: 200,
                        width: 250,
                        child: Column(
                          children: [
                            Image.network(
                              'http:${currentWeather.current.condition.icon}',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              '${currentWeather.current.tempC.toInt()}°C',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              currentWeather.current.condition.text,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Pressure'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${currentWeather.current.pressureMb.toInt()} mb',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Visibility'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${currentWeather.current.visKm.toInt()} Km',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Humidity'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${currentWeather.current.humidity} %',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: upcomingHours.length,
                                itemBuilder: (context, index) {
                                  final forecastHour =
                                      upcomingHours.elementAt(index);
                                  final forecastTime =
                                      DateFormat.Hm().format(forecastHour.time);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ForeCastCard(
                                      forecastTime: forecastTime,
                                      tempC: '${forecastHour.tempC}',
                                      condition: forecastHour.condition.text,
                                      icon: forecastHour.condition.icon,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something Went Wrong..",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    color: Color(0xff7c4dff),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
