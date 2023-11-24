import 'dart:convert';
List<UserModal> userModalfromJson(String string) {
  return List<UserModal>.from(
      json.decode(string).map((e) => UserModal.fromJson(e)));
}

String UsermodalToJson(List<UserModal> data) {
  return json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
}

class UserModal {
  final int? id;
  final String? name;
  final String? userName;
  final String? email;
  final Address? address;

  UserModal(
      {required this.id,
      required this.name,
      required this.userName,
      required this.email,
      required this.address});
  factory UserModal.fromJson(Map<String, dynamic> json) {
    return UserModal(
        id: json['id'],
        name: json[' name'],
        userName: json['userName'],
        email: json['email'],
        address: json['address'] != null
            ? Address.fromjoson(json['address'])
            : null);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      "email": email,
      "address": address
    };
  }
}

class Address {
  final String street;
  final String city;
  final String zipcode;

  Address({required this.street, required this.city, required this.zipcode});
  factory Address.fromjoson(Map<String, dynamic> json) {
    return Address(
        street: json['street'], city: json['city'], zipcode: json['zipcode']);
  }
}
