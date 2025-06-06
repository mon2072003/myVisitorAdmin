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

  static Future<void> addActivity({required ActivitiesModel activity, required String city}) async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
      .collection('egy_data')
      .where('name', isEqualTo: city)
      .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      await firestore
        .collection('egy_data')
        .doc(doc.id)
        .collection('activities').doc(activity.title).set(activity.toList());
    }
  }

  static Future<void> deleteActivity({required String city, required String title}) async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
      .collection('egy_data')
      .where('name', isEqualTo: city)
      .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final activitiesQuery = await firestore
        .collection('egy_data')
        .doc(doc.id)
        .collection('activities')
        .where('title', isEqualTo: title)
        .get();

      if (activitiesQuery.docs.isNotEmpty) {
        await firestore
          .collection('egy_data')
          .doc(doc.id)
          .collection('activities')
          .doc(activitiesQuery.docs.first.id)
          .delete();
      }
    }
  }

  static Future<void> updateTitle({
    required String city,
    required String oldTitle,
    required String newTitle,
  }
  ) async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
      .collection('egy_data')
      .where('name', isEqualTo: city)
      .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final activitiesQuery = await firestore
        .collection('egy_data')
        .doc(doc.id)
        .collection('activities')
        .where('title', isEqualTo: oldTitle)
        .get();

      if (activitiesQuery.docs.isNotEmpty) {
        await firestore
          .collection('egy_data')
          .doc(doc.id)
          .collection('activities')
          .doc(activitiesQuery.docs.first.id)
          .update({'title': newTitle});
      }
    }
  }

  static Future<void> updateDescription({
    required String city,
    required String oldDescription,
    required String newDescription,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
      .collection('egy_data')
      .where('name', isEqualTo: city)
      .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final activitiesQuery = await firestore
        .collection('egy_data')
        .doc(doc.id)
        .collection('activities')
        .where('description', isEqualTo: oldDescription)
        .get();

      if (activitiesQuery.docs.isNotEmpty) {
        await firestore
          .collection('egy_data')
          .doc(doc.id)
          .collection('activities')
          .doc(activitiesQuery.docs.first.id)
          .update({'description': newDescription});
      }
    }
  }
}
