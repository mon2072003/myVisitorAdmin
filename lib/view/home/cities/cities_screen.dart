import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/view-model/home/cities_cubit/cities_cubit.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/city_details_screen.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CitiesCubit(),
      child: Scaffold(
        body: BlocBuilder<CitiesCubit, CitiesState>(
          builder: (context, state) {
            if (state is CitiesInitial) {
              context.read<CitiesCubit>().getPlaces();
              return const Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final place = state.cities[index];
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CityDetailsScreen(city: place)));
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
