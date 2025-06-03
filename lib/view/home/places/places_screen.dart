import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/view-model/home/places_cubit/places_cubit.dart';
import 'package:my_visitor_admin/view/home/places/place_details/place_details_screen.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesCubit(),
      child: Scaffold(
        body: BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesInitial) {
              context.read<PlacesCubit>().getPlaces();
              return const Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: state.places.length,
              itemBuilder: (context, index) {
                final place = state.places[index];
                return Card(
                  child: ListTile(
                    title: Text(place.name!,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                    subtitle: Text(place.description!,style: TextStyle(overflow: TextOverflow.ellipsis),maxLines: 2,),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepOrange,
                      child: Center(child: Text("${index+1}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceDetailsScreen(place: place)));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
