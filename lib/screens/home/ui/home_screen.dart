import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/blocs/blocs.dart';
import 'package:weather_application/screens/home/components/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _locationBloc = BlocProvider.of<LocationBloc>(context);
  late final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

  @override
  void initState() {
    _locationBloc.add(LocationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SafeArea(
          child: Text('Weather App by Logic'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoaded) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: state.weather.weatherMain == 'Clear'
                            ? const DecorationImage(
                                image: AssetImage('assets/sunny.jpeg'),
                                fit: BoxFit.cover,
                              )
                            : state.weather.weatherMain == 'Clouds' ||
                                    state.weather.weatherMain == 'Smoke'
                                ? const DecorationImage(
                                    image: AssetImage('assets/smoke.jpeg'),
                                    fit: BoxFit.cover,
                                  )
                                : state.weather.weatherMain == 'Rain'
                                    ? const DecorationImage(
                                        image: AssetImage('assets/rain.jpeg'),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage('assets/404.jpeg'),
                                        fit: BoxFit.cover,
                                      ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.weather.cityName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.weather.temperature.toStringAsFixed(1)}°C',
                                  style: const TextStyle(fontSize: 50),
                                ),
                                const SizedBox(width: 20),
                                Image.network(
                                  'https://openweathermap.org/img/w/${state.weather.iconCode}.png',
                                  scale: 0.5,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              state.weather.weatherMain,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text('Search for a location');
                  }
                },
              ),
              const SizedBox(height: 40),

              //TODO: In location form the past searches will be saved, and shown in suggestions. and that will be looped from for search. Otherwise new city will directly go to the
              LocationForm(
                onSubmitted: (String city) {
                  _locationBloc.add(AddSearchLocation(city));
                  _weatherBloc.add(GetWeather(city));
                },
              ),
              const SizedBox(height: 20),

              BlocBuilder<LocationBloc, LocationState>(
                bloc: _locationBloc,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LocationLoading:
                      return const CircularProgressIndicator();
                    case LocationLoaded:
                      return Column(
                        children: [
                          const Text('Favourites'),
                          const SizedBox(height: 20),
                          if ((state as LocationLoaded)
                              .favoriteLocations
                              .isNotEmpty)
                            FavouritesList(
                              favoriteLocations: state.favoriteLocations,
                            )
                          else
                            const Center(
                              child: Text('No Favourites'),
                            ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          const Text('Search History'),
                          const SizedBox(height: 20),
                          SearchList(
                            searchLocations: (state as LocationLoaded)
                                .searchLocations
                                .reversed
                                .toList(),
                          ),
                        ],
                      );
                    default:
                      return const Text('Something went wrong');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
