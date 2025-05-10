import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_visitor_admin/model/contacts/hotel_reservation_model/hotel_reservation_model.dart';

class HotelReservationsAPI {
List<HotelReservationModel> hotel_reservation_model=[];
Future<List<HotelReservationModel>> getReservations({required String email})async{
  final firestore = FirebaseFirestore.instance;
  final usersCollection = firestore.collection('users').doc(email).collection('booking_history');
  try {
    final querySnapshot = await usersCollection.get();
    hotel_reservation_model = querySnapshot.docs.map((doc) => HotelReservationModel.fromJson(doc.data())).toList();
  } catch (e) {
    debugPrint('Error fetching users: $e');
  }
return hotel_reservation_model;
}
}