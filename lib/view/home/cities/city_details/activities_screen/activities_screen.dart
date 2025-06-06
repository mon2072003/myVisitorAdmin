import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';
import 'package:my_visitor_admin/services/cities/activities/activities.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/activities_screen/activity_details_screen/activity_details_screen.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/activities_screen/add_activity/add_activity_screen.dart';

class ActivitiesScreen extends StatelessWidget {
  List<ActivitiesModel>? activitiesModel;
  String? cityName;
  ActivitiesScreen({
    super.key,
    required this.activitiesModel,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).activities)),
      body:
          activitiesModel == null || activitiesModel!.isEmpty
              ? Center(child: Text(S.of(context).no_activities_available))
              : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: activitiesModel!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onLongPress:
                          () => showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text(S.of(context).delete_activity),
                                  content: Text(
                                    S
                                        .of(context)
                                        .are_you_sure_you_want_to_delete_this_activity,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        S.of(context).cancel,
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Call delete activity function here
                                        Activities.deleteActivity(
                                          city: cityName!,
                                          title: activitiesModel![index].title!,
                                        );
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              S
                                                  .of(context)
                                                  .activity_deleted_successfully,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                      child: Text(S.of(context).delete,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),)
                                    ),
                                  ],
                                ),
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
                      title: Text(
                        activitiesModel![index].title ??
                            S.of(context).unKnown_activity,
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        activitiesModel![index].description ??
                            S.of(context).no_description_available,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => ActivityDetailsScreen(
                                    activity: activitiesModel![index],
                                    cityName: cityName,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddActivityScreen(cityName: cityName!),
            ),
          );
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
      ),
    );
  }
}
