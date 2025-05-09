class ContactsModel {
  String? email;
  String? name;
  String? phoneNumber;
  String? profileImageUrl;

  ContactsModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  ContactsModel.fromList(Map<String, dynamic> snapshot) {
    email = snapshot['email'] ?? "not available";
    name = snapshot['name'] ?? "not available";
    phoneNumber = snapshot['phoneNumber'] ?? "not available";
    profileImageUrl =
        snapshot['profileImageUrl'] != "assets/images/defualt_profile.png"
            ? snapshot['profileImageUrl'] ?? "https://th.bing.com/th/id/OIP.yNEIwvAlvp4q71Mfj0NZaQHaHa?cb=iwc1&rs=1&pid=ImgDetMain"
            : "https://th.bing.com/th/id/OIP.yNEIwvAlvp4q71Mfj0NZaQHaHa?cb=iwc1&rs=1&pid=ImgDetMain";
  }

  Map<String, dynamic> toList() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    };
  }
}
