import 'package:flutter/material.dart';
import 'package:my_visitor_admin/model/contacts/hotel_reservation_model/hotel_reservation_model.dart';

class HotelCard extends StatelessWidget {
  HotelReservationModel hotel;
  HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: ListTile(
        title: Text(hotel.hotel.name, style: TextStyle(color: Colors.black)),
        subtitle: Column(
          children: [
            Text(
              hotel.bookDetails.checkIn,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              hotel.bookDetails.checkOut,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        trailing: Text(
          "${hotel.payment.amountCents.toString()} ${hotel.payment.currency}",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
