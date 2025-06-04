part of 'cities_cubit.dart';

sealed class CitiesState {
  List<CityModel> cities;
  CitiesState({required this.cities});
}

final class CitiesInitial extends CitiesState {
  CitiesInitial() : super(cities: []);
}

final class CitiesLoaded extends CitiesState {
  CitiesLoaded({required super.cities});
}
