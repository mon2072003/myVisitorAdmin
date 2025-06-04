import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_visitor_admin/model/cities/cities_model.dart';

class Cities {
  List<CityModel> places = [];
  Future<List<CityModel>> getCities() async {
    final firestore = FirebaseFirestore.instance;
    final placesCollection = firestore.collection('egy_data');
    try {
      final querySnapshot = await placesCollection.get();
      places =
          querySnapshot.docs
              .map((doc) => CityModel.fromList(doc.data()))
              .toList();
    } catch (e) {
      debugPrint('Error fetching places: $e');
    }
    return places;
  }

  static Future<void> changeCityName({
    required String oldName,
    required String newName,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final placesCollection = firestore.collection('egy_data');
    await placesCollection.where('name', isEqualTo: oldName).get().then((
      snapshot,
    ) {
      for (var doc in snapshot.docs) {
        doc.reference
            .update({'name': newName})
            .then((_) {
              debugPrint('Place name updated successfully');
            })
            .catchError((error) {
              debugPrint('Error updating place name: $error');
            });
      }
    });
  }

  static Future<void> changeDescription({
    required String oldDescription,
    required String newDescription,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final placesCollection = firestore.collection('egy_data');
    await placesCollection
        .where('description', isEqualTo: oldDescription)
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference
                .update({'description': newDescription})
                .then((_) {
                  debugPrint('Place description updated successfully');
                })
                .catchError((error) {
                  debugPrint('Error updating place description: $error');
                });
          }
        });
  }

  static Future<void> addTouristPlaces({
    required List<String> touristPlaces,
    required String newTouristPlace,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final placesCollection = firestore.collection('egy_data');
    placesCollection
        .where("tourist_places", isEqualTo: touristPlaces)
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            List<String> updatedTouristPlaces = List.from(touristPlaces);
            updatedTouristPlaces.add(newTouristPlace);
            doc.reference
                .update({'tourist_places': updatedTouristPlaces})
                .then((_) {
                  debugPrint('Tourist place added successfully');
                })
                .catchError((error) {
                  debugPrint('Error adding tourist place: $error');
                });
          }
        })
        .catchError((error) {
          debugPrint('Error fetching tourist places: $error');
        });
  }

  static Future<void> deleteTouristPlace({required String touristPlace}) async {
    final firestore = FirebaseFirestore.instance;
    final placesCollection = firestore.collection('egy_data');
    placesCollection
        .where("tourist_places", arrayContains: touristPlace)
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            List<String> updatedTouristPlaces = List.from(
              doc.data()['tourist_places'],
            );
            updatedTouristPlaces.remove(touristPlace);
            doc.reference
                .update({'tourist_places': updatedTouristPlaces})
                .then((_) {
                  debugPrint('Tourist place deleted successfully');
                })
                .catchError((error) {
                  debugPrint('Error deleting tourist place: $error');
                });
          }
        })
        .catchError((error) {
          debugPrint('Error fetching tourist places: $error');
        });
  }
}
