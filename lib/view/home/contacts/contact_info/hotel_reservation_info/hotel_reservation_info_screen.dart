import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/contacts/hotel_reservation_model/hotel_reservation_model.dart';

class HotelReservationInfoScreen extends StatelessWidget {
  final HotelReservationModel hotelReservationModel;
  const HotelReservationInfoScreen({super.key, required this.hotelReservationModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).hotel_reservation_info),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (hotelReservationModel.hotel.images.isNotEmpty)
              SizedBox(
                height: 220,
                child: PageView.builder(
                  itemCount: hotelReservationModel.hotel.images.length,
                  itemBuilder: (context, index) {
                    final image = hotelReservationModel.hotel.images[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          image.original_image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                S.of(context).image_not_available,
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.hotel,
              label: S.of(context).hotel_name,
              value: hotelReservationModel.hotel.name,
            ),
            SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.star,
              label: S.of(context).hotel_rating,
              value: '${hotelReservationModel.hotel.overall_rating} / 5',
            ),
            SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: S.of(context).check_in,
              value: hotelReservationModel.hotel.check_in_time,
            ),
            SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.calendar_today_outlined,
              label: S.of(context).check_out,
              value: hotelReservationModel.hotel.check_out_time,
            ),
            SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.people,
              label: S.of(context).guests,
              value: '${hotelReservationModel.bookDetails.guest} ${S.of(context).guests}',
            ),
            SizedBox(height: 16),
            Text(
              S.of(context).payment_info,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.attach_money,
              label: S.of(context).total_amount,
              value: '${hotelReservationModel.payment.currency} ${hotelReservationModel.payment.amountCents / 100}',
            ),
            SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.payment,
              label: S.of(context).payment_status,
              value: hotelReservationModel.payment.success
                  ? S.of(context).payment_successful
                  : S.of(context).payment_failed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepOrange),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.end,
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
