
import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';
import 'package:my_visitor_admin/view/home/cities/city_details/activities_screen/activity_details_screen/activity_details_screen.dart';

class ActivitiesScreen extends StatelessWidget {
  List<ActivitiesModel>? activitiesModel;
  ActivitiesScreen({super.key, required this.activitiesModel});

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
                        style: TextStyle(color: Colors.deepOrange),
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
        onPressed: () {},
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
      ),
    );
  }
}
