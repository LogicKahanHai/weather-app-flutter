import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/blocs/blocs.dart';
import 'package:weather_application/repos/weather_repo.dart';

class SearchList extends StatefulWidget {
  final List<String> searchLocations;
  const SearchList({super.key, required this.searchLocations});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return widget.searchLocations.isEmpty
        ? const Center(
            child: Text('No Past Searches'),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.searchLocations.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final location = widget.searchLocations[index];
              return ListTile(
                title: Text(location),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<LocationBloc>(context)
                            .add(AddFavoriteLocation(location));
                      },
                      icon: Icon(
                        WeatherRepository.favouriteLocations.contains(location)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: WeatherRepository.favouriteLocations
                                .contains(location)
                            ? Colors.red
                            : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        BlocProvider.of<LocationBloc>(context)
                            .add(RemoveSearchLocation(location));
                      },
                    ),
                  ],
                ),
              );
            },
          );
  }
}
