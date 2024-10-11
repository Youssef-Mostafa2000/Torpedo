import 'package:delivery_agent_app/models/Address.dart';

class Customer {
  final int? id;
  final String? name;
  final int? phoneNumber;
  final String? role;
  final List<Address>? addresses;

  Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.addresses,
    this.role,
  });

  factory Customer.fromJson(json) {
    var addrList = json['addresses'] != null ? json['addresses'] as List : [];
    List<Address> addressesList = addrList.length > 0
        ? addrList.map((i) => Address.fromJson(i)).toList()
        : [];

    return Customer(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      addresses: addressesList,
      role: json['role'],
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
