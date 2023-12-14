part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<String> favoriteLocations;
  final List<String> searchLocations;

  LocationLoaded(this.favoriteLocations, this.searchLocations);

  Map<String, dynamic> toJson() {
    print('toJson');
    print(favoriteLocations);
    print(searchLocations);
    return {
      'favoriteLocations': favoriteLocations,
      'searchLocations': searchLocations,
    };
  }

  factory LocationLoaded.fromJson(Map<String, dynamic> json) {
    return LocationLoaded(
      json['favoriteLocations'] as List<String>,
      json['searchLocations'] as List<String>,
    );
  }
}
