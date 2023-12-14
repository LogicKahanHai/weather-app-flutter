part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class LocationInitialEvent extends LocationEvent {}

class AddFavoriteLocation extends LocationEvent {
  final String city;

  AddFavoriteLocation(this.city);
}

class RemoveFavoriteLocation extends LocationEvent {
  final String city;

  RemoveFavoriteLocation(this.city);
}

class AddSearchLocation extends LocationEvent {
  final String city;

  AddSearchLocation(this.city);
}

class RemoveSearchLocation extends LocationEvent {
  final String city;

  RemoveSearchLocation(this.city);
}
