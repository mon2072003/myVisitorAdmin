part of 'places_cubit.dart';

sealed class PlacesState {
  List<PlaceModel> places;
  PlacesState({required this.places});
}

final class PlacesInitial extends PlacesState {
  PlacesInitial() : super(places: []);
}

final class PlacesLoaded extends PlacesState {
  PlacesLoaded({required super.places});
}
