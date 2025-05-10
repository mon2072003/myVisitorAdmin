part of 'hotel_reservation_cubit.dart';

sealed class HotelReservationState {
  List<HotelReservationModel> hotels;
  HotelReservationState({required this.hotels});
}

final class HotelReservationInitial extends HotelReservationState {
  HotelReservationInitial():super(hotels: []);
}
final class HotelReservationLoaded extends HotelReservationState {
  HotelReservationLoaded({required super.hotels});
}
