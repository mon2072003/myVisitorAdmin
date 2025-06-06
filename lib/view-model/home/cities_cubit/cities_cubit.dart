import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/model/cities/cities_model.dart';
import 'package:my_visitor_admin/services/cities/cities.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());
  List<CityModel> cities = [];
  Cities citiesService = Cities();
  void getPlaces() async{
    cities = await citiesService.getCities();
    emit(CitiesLoaded(cities: cities));
  }
  void deleteCity(String cityName) async {
    await citiesService.deleteCity(name: cityName);
    getPlaces();
  }
}
