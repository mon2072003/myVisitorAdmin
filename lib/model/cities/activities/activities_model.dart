class ActivitiesModel {
  String? description;
  List<String>? images;
  Location? location;
  String? title;

  ActivitiesModel({
    required this.description,
    required this.images,
    required this.location,
    required this.title,
  });

  factory ActivitiesModel.fromList(Map<String,dynamic> json) {
    return ActivitiesModel(
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      location: json['location'] != null
          ? Location.fromList(json['location'])
          : Location(latitude: 0, longitude: 0),
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toList() => {
        'description': description,
        'images': images,
        'location': location?.toList(),
        'title': title,
      };
}

class Location {
  num? latitude;
  num? longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromList(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toList() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
