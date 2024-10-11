import 'package:delivery_agent_app/models/Shipment.dart';

class DeliveryAgent {
  final int? id;
  final String? name;
  final int? phoneNumber;
  final String? role;
  //final List<Shipment>? shipments;

  DeliveryAgent({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    //required this.shipments,
  });

  factory DeliveryAgent.fromJson(json) {
    /*var list = json['shipments'] as List;
    List<Shipment> shipmentsList =
        list.map((i) => Shipment.fromJson(i)).toList();*/

    return DeliveryAgent(
      id: json['id'],
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? 0,
      role: json['role'] ?? '',
      //shipments: shipmentsList ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name ?? '',
      'id': id,
      'phoneNumber': phoneNumber ?? 0,
      'role': role ?? '',
      //'shipments': shipments!.map((shipment) => shipment.toJson()).toList(),
    };
  }
}
