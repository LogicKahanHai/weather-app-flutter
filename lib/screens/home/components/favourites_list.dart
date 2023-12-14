import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/blocs/blocs.dart';

class FavouritesList extends StatefulWidget {
  final List<String> favoriteLocations;
  const FavouritesList({super.key, required this.favoriteLocations});

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  @override
  Widget build(BuildContext context) {
    return widget.favoriteLocations.isEmpty
        ? const Center(
            child: Text('No Favourites'),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.favoriteLocations.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final location = widget.favoriteLocations[index];
              return ListTile(
                title: Text(location),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    BlocProvider.of<LocationBloc>(context)
                        .add(RemoveFavoriteLocation(location));
                  },
                ),
              );
            },
          );
  }
}
