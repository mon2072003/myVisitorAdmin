import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
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
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final place = state.cities[index];
                return Card(
                  child: ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context1) {
                          return AlertDialog(
                            title: Text(S.of(context).delete_city),
                            content: Text(
                              "Are you sure you want to delete ${place.name}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<CitiesCubit>().deleteCity(
                                    place.name!,
                                  );
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${place.name} deleted successfully",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: Text(
                                  S.of(context).delete,
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(
                      place.name!,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      place.description!,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepOrange,
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CityDetailsScreen(city: place),
                          ),
                        );
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
            Navigator.pushNamed(context, "/add-new-city");
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
