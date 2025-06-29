import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';
import 'package:my_visitor_admin/services/cities/activities/activities.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/city_details_screen.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final ActivitiesModel? activity;
  final String? cityName;
  const ActivityDetailsScreen({super.key, required this.activity, required this.cityName});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  final MapController mapController = MapController();
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: widget.activity?.description ?? '',
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).activity_details),
        centerTitle: true,
        elevation: 2,
      ),
      body: activity == null
          ?  Center(
            child: Text(
              S.of(context).no_activities_found,
              style: TextStyle(fontSize: 18),
            ),
          )
          : Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                // Title
                Row(
                  children: [
                  Expanded(
                    child: Text(
                    activity.title ?? S.of(context).no_title_available,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                    final titleController = TextEditingController(
                      text: activity.title ?? '',
                    );
                    await customBottomSheet(
                      context: context,
                      controller: titleController,
                      onPressed: (context) async{
                      // Update the title here
                      await Activities.updateTitle(
                        city: widget.cityName!,
                        oldTitle: activity.title!,
                        newTitle: titleController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text(
                          S.of(context).title_updated_successfully,
                          style: const TextStyle(color: Colors.white),
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
                
                const SizedBox(height: 20),
                // Images
                if (activity.images != null && activity.images!.isNotEmpty)
                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: activity.images!.length,
                      separatorBuilder:
                          (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            activity.images![index],
                            width: 220,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  color: Colors.grey[200],
                                  width: 220,
                                  height: 220,
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                if (activity.images != null && activity.images!.isNotEmpty)
                  const SizedBox(height: 20),
                // Description with edit button
                if (activity.description != null &&
                    activity.description!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).description,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () async {
                              textController.text = activity.description!;
                              await customBottomSheet(
                                context: context,
                                controller: textController,
                                onPressed: (context) async{
                                  // Update the description here
                                  await Activities.updateDescription(
                                    city: widget.cityName!,
                                    oldDescription: activity.description!,
                                    newDescription: textController.text,
                                  );
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
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
                                  Navigator.of(
                                    context,
                                  ).pushNamedAndRemoveUntil(
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
                      const SizedBox(height: 8),
                      Text(
                        activity.description!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                // Location
                if (activity.location != null)
                  SizedBox(
                    height: 200,
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: LatLng(
                          (activity.location!.latitude ?? 0).toDouble(),
                          (activity.location!.longitude ?? 0)
                              .toDouble(),
                        ),
                        maxZoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 40,
                              height: 40,
                              point: LatLng(
                                (activity.location!.latitude ?? 0)
                                    .toDouble(),
                                (activity.location!.longitude ?? 0)
                                    .toDouble(),
                              ),
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                // Add more fields as needed from ActivitiesModel
              ],
            ),
          ),
    );
  }
}
