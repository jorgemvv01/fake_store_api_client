import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Address address;
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final String phone;

  const User({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    address: Address.fromJson(json["address"]),
    id: json["id"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    name: Name.fromJson(json["name"]),
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address.toJson(),
    "id": id,
    "email": email,
    "username": username,
    "password": password,
    "name": name.toJson(),
    "phone": phone,
  };

  @override
  List<Object?> get props => [address, id, email, username, password, name, phone];

  User copyWith({
    Address? address,
    int? id,
    String? email,
    String? username,
    String? password,
    Name? name,
    String? phone,
  }) {
    return User(
      address: address ?? this.address,
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}

class Address extends Equatable {
    final Geolocation geolocation;
    final String city;
    final String street;
    final int number;
    final String zipcode;

    const Address({
        required this.geolocation,
        required this.city,
        required this.street,
        required this.number,
        required this.zipcode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        geolocation: Geolocation.fromJson(json["geolocation"]),
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "geolocation": geolocation.toJson(),
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
    };

    @override
    List<Object?> get props => [geolocation, city, street, number, zipcode];
}

class Geolocation extends Equatable{
    final String lat;
    final String long;

    const Geolocation({
        required this.lat,
        required this.long,
    });

    factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lat: json["lat"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
    };

    @override
    List<Object?> get props => [lat, long];
}

class Name extends Equatable{
    final String firstname;
    final String lastname;

    const Name({
        required this.firstname,
        required this.lastname,
    });

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
    };

    @override
    List<Object?> get props => [firstname, lastname];
}
