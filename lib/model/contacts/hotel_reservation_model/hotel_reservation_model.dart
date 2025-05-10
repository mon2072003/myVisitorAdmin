
class HotelReservationModel {
  final BookDetails bookDetails;
  final Hotel hotel;
  final Payment payment;

  HotelReservationModel({
    required this.bookDetails,
    required this.hotel,
    required this.payment
  });

  factory HotelReservationModel.fromJson(Map<String, dynamic> json) {
    return HotelReservationModel(
      bookDetails: BookDetails.fromJson(json['bookDetails']),
      hotel: Hotel.fromJson(json['hotel']),
      payment: Payment.fromJson(json['payment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookDetails': bookDetails.toJson(),
      'hotel': hotel.toJson(),
    };
  }
}

class BookDetails {
  final String checkIn;
  final String checkOut;
  final int guest;
  final int noRooms;

  BookDetails({
    required this.checkIn,
    required this.checkOut,
    required this.guest,
    required this.noRooms,
  });

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      guest: json['guest'],
      noRooms: json['noRooms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkIn': checkIn,
      'checkOut': checkOut,
      'guest': guest,
      'noRooms': noRooms,
    };
  }
}

class Hotel {
  final List<String> aminities;
  final String check_in_time;
  final String check_out_time;
  final String deal;
  final String deal_description;
  final String description;
  final Gps_Coordinates gps_coordinates;
  final List<Images> images;
  final String link;
  final num location_rating;
  final String name;
  final List<Nearby_Places> nearby_places;
  final num overall_rating;
  final String property_token;
  final Rate_Per_Night rate_per_night;
  final List<Ratings> ratings;
  final num reviews;
  final List<Reviews_Breakdown> reviews_breakdown;
  final String serpapi_property_details_link;
  final Total_Rate total_rate;
  final String type;

  Hotel({
    required this.aminities,
    required this.check_in_time,
    required this.check_out_time,
    required this.deal,
    required this.deal_description,
    required this.description,
    required this.gps_coordinates,
    required this.images,
    required this.link,
    required this.location_rating,
    required this.name,
    required this.nearby_places,
    required this.overall_rating,
    required this.property_token,
    required this.rate_per_night,
    required this.ratings,
    required this.reviews,
    required this.reviews_breakdown,
    required this.serpapi_property_details_link,
    required this.total_rate,
    required this.type,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      aminities: json['aminities'] != null ? List<String>.from(json['aminities']) : [],
      check_in_time: json['check_in_time'],
      check_out_time: json['check_out_time'],
      deal: json['deal'],
      deal_description: json['deal_description'],
      description: json['description'],
      gps_coordinates: Gps_Coordinates.fromJson(json['gps_coordinates']),
      images: json['images'] != null ? (json['images'] as List).map((e) => Images.fromJson(e)).toList() : [],
      link: json['link'],
      location_rating: json['location_rating'],
      name: json['name'],
      nearby_places: json['nearby_places'] != null
          ? (json['nearby_places'] as List).map((e) => Nearby_Places.fromJson(e)).toList()
          : [],
      overall_rating: json['overall_rating'],
      property_token: json['property_token'],
      rate_per_night: Rate_Per_Night.fromJson(json['rate_per_night']),
      ratings:
          (json['ratings'] as List).map((e) => Ratings.fromJson(e)).toList(),
      reviews: json['reviews'],
      reviews_breakdown: json['reviews_breakdown'] != null
          ? (json['reviews_breakdown'] as List).map((e) => Reviews_Breakdown.fromJson(e)).toList()
          : [],
      serpapi_property_details_link: json['serpapi_property_details_link'],
      total_rate: Total_Rate.fromJson(json['total_rate']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aminities': aminities,
      'check_in_time': check_in_time,
      'check_out_time': check_out_time,
      'deal': deal,
      'deal_description': deal_description,
      'description': description,
      'gps_coordinates': gps_coordinates.toJson(),
      'images': images.map((e) => e.toJson()).toList(),
      'link': link,
      'location_rating': location_rating,
      'name': name,
      'nearby_places': nearby_places.map((e) => e.toJson()).toList(),
      'overall_rating': overall_rating,
      'property_token': property_token,
      'rate_per_night': rate_per_night.toJson(),
      'ratings': ratings.map((e) => e.toJson()).toList(),
      'reviews': reviews,
      'reviews_breakdown': reviews_breakdown.map((e) => e.toJson()).toList(),
      'serpapi_property_details_link': serpapi_property_details_link,
      'total_rate': total_rate.toJson(),
      'type': type,
    };
  }
}

class Gps_Coordinates {
  final num latitude;
  final num longitude;

  Gps_Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Gps_Coordinates.fromJson(Map<String, dynamic> json) {
    return Gps_Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Images {
  final String original_image;
  final String thumbnail;

  Images({
    required this.original_image,
    required this.thumbnail,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      original_image: json['original_image'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_image': original_image,
      'thumbnail': thumbnail,
    };
  }
}

class Nearby_Places {
  final String name;
  final List<Transportations> transportations;

  Nearby_Places({
    required this.name,
    required this.transportations,
  });

  factory Nearby_Places.fromJson(Map<String, dynamic> json) {
    return Nearby_Places(
      name: json['name'],
      transportations: json['transportations'] != null
          ? (json['transportations'] as List).map((e) => Transportations.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'transportations': transportations.map((e) => e.toJson()).toList(),
    };
  }
}

class Transportations {
  final String duration;
  final String type;

  Transportations({
    required this.duration,
    required this.type,
  });

  factory Transportations.fromJson(Map<String, dynamic> json) {
    return Transportations(
      duration: json['duration'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'type': type,
    };
  }
}

class Rate_Per_Night {
  final num extracted_lowest;
  final String lowest;

  Rate_Per_Night({
    required this.extracted_lowest,
    required this.lowest,
  });

  factory Rate_Per_Night.fromJson(Map<String, dynamic> json) {
    return Rate_Per_Night(
      extracted_lowest: json['extracted_lowest'],
      lowest: json['lowest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extracted_lowest': extracted_lowest,
      'lowest': lowest,
    };
  }
}

class Ratings {
  final num count;
  final num stars;

  Ratings({
    required this.count,
    required this.stars,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      count: json['count'],
      stars: json['stars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'stars': stars,
    };
  }
}

class Reviews_Breakdown {
  final String description;
  final String name;
  final num negative;
  final num neutral;
  final num positive;
  final num total_mentioned;

  Reviews_Breakdown({
    required this.description,
    required this.name,
    required this.negative,
    required this.neutral,
    required this.positive,
    required this.total_mentioned,
  });

  factory Reviews_Breakdown.fromJson(Map<String, dynamic> json) {
    return Reviews_Breakdown(
      description: json['description'],
      name: json['name'],
      negative: json['negative'],
      neutral: json['neutral'],
      positive: json['positive'],
      total_mentioned: json['total_mentioned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'name': name,
      'negative': negative,
      'neutral': neutral,
      'positive': positive,
      'total_mentioned': total_mentioned,
    };
  }
}

class Total_Rate {
  final num extracted_lowest;
  final String lowest;

  Total_Rate({
    required this.extracted_lowest,
    required this.lowest,
  });

  factory Total_Rate.fromJson(Map<String, dynamic> json) {
    return Total_Rate(
      extracted_lowest: json['extracted_lowest'],
      lowest: json['lowest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extracted_lowest': extracted_lowest,
      'lowest': lowest,
    };
  }
}



class Payment {
  final int amountCents;
  final String createdAt;
  final String currency;
  final int id;
  final bool isAuth;
  final bool isCapture;
  final bool isRefunded;
  final bool isStandalonePayment;
  final bool isVoided;
  final bool pending;
  final bool success;

  Payment({
    required this.amountCents,
    required this.createdAt,
    required this.currency,
    required this.id,
    required this.isAuth,
    required this.isCapture,
    required this.isRefunded,
    required this.isStandalonePayment,
    required this.isVoided,
    required this.pending,
    required this.success,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      amountCents: json['amount_cents'],
      createdAt: json['created_at'],
      currency: json['currency'],
      id: json['id'],
      isAuth: json['is_auth'],
      isCapture: json['is_capture'],
      isRefunded: json['is_refunded'],
      isStandalonePayment: json['is_standalone_payment'],
      isVoided: json['is_voided'],
      pending: json['pending'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount_cents': amountCents,
      'created_at': createdAt,
      'currency': currency,
      'id': id,
      'is_auth': isAuth,
      'is_capture': isCapture,
      'is_refunded': isRefunded,
      'is_standalone_payment': isStandalonePayment,
      'is_voided': isVoided,
      'pending': pending,
      'success': success,
    };
  }
}