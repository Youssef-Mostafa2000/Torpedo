import 'dart:convert';

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
    var list = json['addresses'] as List;
    List<Address> addressesList = list.map((i) => Address.fromJson(i)).toList();

    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      addresses: addressesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'phoneNumber': phoneNumber,
      'role': role,
      'addresses': addresses!.map((address) => address.toJson()).toList()
    };
  }
}
