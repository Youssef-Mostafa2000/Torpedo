import 'package:admin_app/models/Shipment.dart';

class DeliveryAgent {
  final int? id;
  final String? name;
  final int? phoneNumber;
  final String? role;
  final List<Shipment>? shipments;

  DeliveryAgent({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.shipments,
  });

  factory DeliveryAgent.fromJson(json) {
    var list = json['shipments'] as List;
    List<Shipment> shipmentsList =
        list.map((i) => Shipment.fromJson(i)).toList();

    return DeliveryAgent(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      shipments: shipmentsList,
    );
  }
}
