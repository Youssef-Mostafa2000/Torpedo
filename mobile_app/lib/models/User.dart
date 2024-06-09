import 'package:mobile_app/models/Address.dart';

class User {
  final int? id;
  final String? name;
  final int? phoneNumber;
  final String? role;
  final List<Address>? addresses;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.addresses,
  });

  factory User.fromJson(json) {
    List<Address> addresses = [];
    for (var address in json['addresses']) {
      Address addr = Address.fromJson(address);
      addresses.add(addr);
    }

    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      addresses: addresses,
    );
  }
}
