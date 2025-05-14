import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/view/home/chats/chat_view.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';
import 'package:my_visitor_admin/view-model/home/hotel_reservation_cubit/hotel_reservation_cubit.dart';
import 'package:my_visitor_admin/widgets/hotel_card.dart';

class ContactInfo extends StatelessWidget {
  ContactsModel contacts;
  ContactInfo({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelReservationCubit(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  contacts.profileImageUrl!,
                  fit: BoxFit.fill,
                  errorBuilder:
                      (context, error, stackTrace) => LottieBuilder.asset(
                        'images/egypt.json',
                        fit: BoxFit.fill,
                        backgroundLoading: true,
                        repeat: true,
                      ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  leading: Icon(Icons.person, color: Colors.deepOrange),
                  title: Text(contacts.name!),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.deepOrange),
                  title: Text(contacts.email!),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.deepOrange),
                  title: Text(contacts.phoneNumber!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushNamed(ChatView.id, arguments: contacts.email);
                    },
                    label: Text(S.of(context).send_message),
                    icon: Icon(Icons.message),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(thickness: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    S.of(context).booking_reservations,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                BlocBuilder<HotelReservationCubit, HotelReservationState>(
                  builder: (context, state) {
                    context.read<HotelReservationCubit>().getHotels(
                      email: contacts.email!,
                    );
                    if (state.hotels.isEmpty) {
                      return Center(
                        child: Image.asset(
                          "images/pyramids.png",
                          height: 200,
                          width: 200,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.hotels.length,
                      itemBuilder:
                          (context, index) =>
                              HotelCard(hotel: state.hotels[index]),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
