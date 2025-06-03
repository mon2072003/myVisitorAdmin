import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/model/places/places_model.dart';
import 'package:my_visitor_admin/services/places/places.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesInitial());
  List<PlaceModel> places = [];
  Places placesService = Places();
  void getPlaces() async{
    places = await placesService.getPlaces();
    emit(PlacesLoaded(places: places));
  }
}
