import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/model/contacts/hotel_reservation_model/hotel_reservation_model.dart';
import 'package:my_visitor_admin/services/contacts/hotel_reservations/hotel_reservations.dart';

part 'hotel_reservation_state.dart';

class HotelReservationCubit extends Cubit<HotelReservationState> {
  HotelReservationCubit() : super(HotelReservationInitial());
  List<HotelReservationModel> hotels=[];
  HotelReservationsAPI hotelReservationsAPI=HotelReservationsAPI();
  void getHotels({required String email})async{
  hotels=await hotelReservationsAPI.getReservations(email: email);
  emit(HotelReservationLoaded(hotels: hotels));
  }
}
