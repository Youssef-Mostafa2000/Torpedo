import 'dart:convert';

import 'package:mobile_app/models/Address.dart';
import 'package:mobile_app/models/Shipment.dart';

class User {
  final int? id;
  final String? name;
  final int? phoneNumber;
  final String? role;
  final List<Address>? addresses;
  // final List<Shipment>? shipments;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.addresses,
    // required this.shipments,
  });

  factory User.fromJson(json) {
    var addrList = json['addresses'] as List;
    List<Address> addressesList =
        addrList.map((i) => Address.fromJson(i)).toList();

    // var shipList = json['shipments'] as List;
    // List<Shipment> shipmentsList =
    //     shipList.map((i) => Shipment.fromJson(i)).toList();

    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      addresses: addressesList,
      // shipments: shipmentsList,
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
