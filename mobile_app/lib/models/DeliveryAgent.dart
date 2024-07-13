import 'package:mobile_app/models/Pickup.dart';
import 'package:mobile_app/models/Shipment.dart';

class DeliveryAgent {
  final int? id;
  final int? phoneNumber;
  final String? name;
  final String? role;
  final List<Pickup>? pickups;
  final List<Shipment>? shipments;

  DeliveryAgent({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    this.shipments,
    this.pickups,
  });

  factory DeliveryAgent.fromJson(json) {
    return DeliveryAgent(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      shipments: json['shipments'],
      pickups: json['pickups'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
      'shipments': shipments,
      'pickups': pickups
    };
  }
}
