import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_application/repos/weather_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends HydratedBloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationInitialEvent>((event, emit) async {
      if (state is LocationLoaded) {
        emit(state);
      } else {
        emit(LocationLoaded(const [], const []));
      }
    });

    on<AddSearchLocation>((event, emit) async {
      WeatherRepository.addSearch(event.city);

      emit(LocationLoaded(
        WeatherRepository.favouriteLocations,
        WeatherRepository.pastLocations,
      ));
    });

    on<RemoveSearchLocation>((event, emit) async {
      WeatherRepository.removeSearch(event.city);

      emit(LocationLoaded(
        WeatherRepository.favouriteLocations,
        WeatherRepository.pastLocations,
      ));
    });

    on<AddFavoriteLocation>((event, emit) async {
      WeatherRepository.addFavouriteLocation(event.city);
      emit(LocationLoaded(
        WeatherRepository.favouriteLocations,
        WeatherRepository.pastLocations,
      ));
    });

    on<RemoveFavoriteLocation>((event, emit) async {
      WeatherRepository.removeFavouriteLocation(event.city);
      emit(LocationLoaded(
        WeatherRepository.favouriteLocations,
        WeatherRepository.pastLocations,
      ));
    });
  }

  @override
  LocationState? fromJson(Map<String, dynamic> json) {
    if (json['searchLocations'] != null) {
      WeatherRepository.favouriteLocations =
          json['favoriteLocations'] as List<String>? ?? [];
      WeatherRepository.pastLocations = json['searchLocations'] as List<String>;
      return LocationLoaded(
        WeatherRepository.favouriteLocations,
        WeatherRepository.pastLocations,
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    if (state is LocationLoaded) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
