import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/city_details_screen.dart';

// Assume you have these utilities available
// import 'package:my_visitor_admin/utils/custom_bottom_sheet.dart';
// import 'package:my_visitor_admin/generated/l10n.dart';
// import 'package:my_visitor_admin/controller/cities.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final ActivitiesModel? activity;

  const ActivityDetailsScreen({super.key, required this.activity});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
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
        title: const Text('Activity Details'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: activity == null
            ? const Center(
                child: Text(
                  'No activity data available.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView(
                children: [
                  // Title
                  Text(
                    activity.title ?? 'No Title',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  // Images
                  if (activity.images != null && activity.images!.isNotEmpty)
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: activity.images!.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              activity.images![index],
                              width: 220,
                              height: 220,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[200],
                                width: 220,
                                height: 220,
                                child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (activity.images != null && activity.images!.isNotEmpty)
                    const SizedBox(height: 20),
                  // Description with edit button
                  if (activity.description != null && activity.description!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Description',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              onPressed: () async {
                                textController.text = activity.description!;
                                await customBottomSheet(
                                  context: context,
                                  controller: textController,
                                  onPressed: (context) {
                                    // Update the description here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          S.of(context).place_description_updated_successfully,
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
                        const SizedBox(height: 8),
                        Text(
                          activity.description!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  // Location
                  if (activity.location != null && activity.location!.toString().isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            activity.location!.latitude.toString(),
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  // Add more fields as needed from ActivitiesModel
                ],
              ),
      ),
    );
  }
}
