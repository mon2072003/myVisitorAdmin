import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';

class Activities {
  static List<ActivitiesModel> activities = [];
  static Future<List<ActivitiesModel>> getActivitiesByCity(String city) async {
    final firestore = FirebaseFirestore.instance;
    activities.clear();
    final snapshot = await firestore
      .collection('egy_data')
      .where('name', isEqualTo: city)
      .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final activitiesCollection = await firestore
        .collection('egy_data')
        .doc(doc.id)
        .collection('activities')
        .get();

      activities.addAll(
      activitiesCollection.docs.map((activityDoc) {
        return ActivitiesModel.fromList(activityDoc.data());
      }),
      );
    }
    return activities;
  }
}
