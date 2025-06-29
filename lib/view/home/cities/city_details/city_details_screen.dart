import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';
import 'package:my_visitor_admin/model/cities/cities_model.dart';
import 'package:my_visitor_admin/services/cities/activities/activities.dart';
import 'package:my_visitor_admin/services/cities/cities.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/activities_screen/activities_screen.dart';

class CityDetailsScreen extends StatefulWidget {
  CityModel? city;

  CityDetailsScreen({super.key, required this.city});

  @override
  State<CityDetailsScreen> createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).city_details),
        actions: [
          IconButton(
            onPressed: () async {
              List<ActivitiesModel> activities =
                  await Activities.getActivitiesByCity(widget.city!.name!);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => ActivitiesScreen(
                        activitiesModel: activities,
                        cityName: widget.city!.name,
                      ),
                ),
              );
            },
            icon: Icon(Icons.more_vert, color: Colors.deepOrange),
          ),
        ],
      ),
      body:
          widget.city == null
              ? const Center(
                child: Text(
                  "No city data available.",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    // Place Name with Icon
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: Colors.deepOrange,
                          size: 32,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.city!.name ?? "No Name",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () async {
                            textController.text = widget.city!.name ?? "";
                            await customBottomSheet(
                              context: context,
                              controller: textController,
                              onPressed: (context) async {
                                await Cities.changeCityName(
                                  oldName: widget.city!.name!,
                                  newName: textController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      S
                                          .of(context)
                                          .place_name_updated_successfully,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/home",
                                  (route) => false,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Place Description with Icon
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.2),
                        border: Border.all(color: Colors.deepOrange, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.description,
                            color: Colors.grey,
                            size: 24,
                          ),
                          SizedBox(
                            height: 40,
                            child: const VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                              width: 20,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.city!.description ??
                                  "No Description available.",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              textController.text =
                                  widget.city!.description ?? "";
                              await customBottomSheet(
                                context: context,
                                controller: textController,
                                onPressed: (context) {
                                  Cities.changeDescription(
                                    oldDescription: widget.city!.description!,
                                    newDescription: textController.text,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        S
                                            .of(context)
                                            .place_description_updated_successfully,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    "/home",
                                    (route) => false,
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          S.of(context).tourist_places,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () async {
                            textController.clear();
                            await customBottomSheet(
                              context: context,
                              controller: textController,
                              onPressed: (context) async {
                                await Cities.addTouristPlaces(
                                  touristPlaces: widget.city!.touristPlaces!,
                                  newTouristPlace: textController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      S
                                          .of(context)
                                          .tourist_place_added_successfully,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/home",
                                  (route) => false,
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.city!.touristPlaces?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            title: Text(
                              widget.city!.touristPlaces?[index] ?? "No Name",
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await Cities.deleteTouristPlace(
                                  touristPlace:
                                      widget.city!.touristPlaces?[index] ?? "",
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      S
                                          .of(context)
                                          .tourist_place_deleted_successfully,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/home",
                                  (route) => false,
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}

Future<void> customBottomSheet({
  required BuildContext context,
  required TextEditingController controller,
  required Function(BuildContext) onPressed,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => onPressed(context),
                icon: const Icon(Icons.send, color: Colors.deepOrange),
                tooltip: S.of(context).send,
              ),
            ],
          ),
        ),
  );
}
