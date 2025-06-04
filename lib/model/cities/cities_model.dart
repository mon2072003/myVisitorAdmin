class CityModel {
  String? name;
  String? description;
  List<String>? touristPlaces;

  CityModel({
    this.name,
    this.description,
    this.touristPlaces,
  });

  factory CityModel.fromList(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      touristPlaces: (json['tourist_places'] != null)
          ? List<String>.from(json['tourist_places'] as List)
          : [],
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