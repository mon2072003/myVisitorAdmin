class PlaceModel {
  String? name;
  String? description;
  List<String>? touristPlaces;

  PlaceModel({
    this.name,
    this.description,
    this.touristPlaces,
  });

  factory PlaceModel.fromList(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      touristPlaces: (json['tourist_places'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toList() {
    return {
      'name': name,
      'description': description,
      'tourist_places': touristPlaces,
    };
  }
}