import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_api/bloc/weather_bloc_bloc.dart';
import 'package:weather_api/components/my_align.dart';
import 'package:weather_api/components/my_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child: Stack(
              children: [
                const MyAlign(
                  alignment: AlignmentDirectional(3, -0.3),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
                const MyAlign(
                  alignment: AlignmentDirectional(-3, -0.3),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
                const MyAlign(
                  alignment: AlignmentDirectional(0, -1.2),
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(color: Color(0xFFFFAB40)),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                fontSize: 18
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Good Morning',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            getWeatherIcon(state.weather.weatherConditionCode!),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                DateFormat('EEEE dd •')
                                    .add_jm()
                                    .format(state.weather.date!),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyWeatherTile(
                                    imgPath: "assets/11.png",
                                    title: "Sunrise",
                                    value: DateFormat()
                                        .add_jm()
                                        .format(state.weather.sunrise!)),
                                MyWeatherTile(
                                    imgPath: "assets/12.png",
                                    title: "Sunset",
                                    value: DateFormat()
                                        .add_jm()
                                        .format(state.weather.sunset!)),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyWeatherTile(
                                    imgPath: "assets/13.png",
                                    title: "Temp Max",
                                    value:
                                        "${state.weather.tempMax!.celsius!.round()} °C"),
                                MyWeatherTile(
                                    imgPath: "assets/14.png",
                                    title: "Temp Min",
                                    value:
                                        "${state.weather.tempMin!.celsius!.round()} °C"),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else if (state is WeatherBlocLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Failed to fetch weather data',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
