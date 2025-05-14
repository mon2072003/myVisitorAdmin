import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/contacts/hotel_reservation_model/hotel_reservation_model.dart';
import 'package:my_visitor_admin/view/home/contacts/contact_info/hotel_reservation_info/hotel_reservation_info_screen.dart';

class HotelCard extends StatelessWidget {
  final HotelReservationModel hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel.hotel.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            S.of(context).check_in,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[600], fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        hotel.bookDetails.checkIn,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.yellow[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            S.of(context).check_out,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[600], fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        hotel.bookDetails.checkOut,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.yellow[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        S.of(context).total_payment,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${hotel.payment.amountCents / 100} ${hotel.payment.currency}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HotelReservationInfoScreen(
                        hotelReservationModel: hotel,
                      ),
                    ),
                  );
                },
                label: Text(S.of(context).view_details,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    )),
                icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.deepOrange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
