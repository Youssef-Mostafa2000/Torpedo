import 'package:mobile_app/models/Customer.dart';
import 'package:mobile_app/models/DeliveryAgent.dart';

class Pickup {
  final int? id;
  final int? shipmentsCount;
  final int? pickedShipments;
  final String? vehicleType;
  final String? status;
  final String? notes;
  final DateTime? date;
  final Customer? customer;
  final DeliveryAgent? deliveryAgent;

  Pickup({
    required this.id,
    required this.shipmentsCount,
    required this.vehicleType,
    this.pickedShipments,
    this.notes,
    this.deliveryAgent,
    this.customer,
    this.status,
    this.date,
  });

  factory Pickup.fromJson(json) {
    return Pickup(
      id: json['id'],
      shipmentsCount: json['shipmentsCount'],
      pickedShipments: json['pickedShipments'],
      vehicleType: json['vehicleType'],
      notes: json['notes'],
      status: json['status'],
      date: json['date'] != null
          ? DateTime.tryParse(json['date'])
          : DateTime.now(),
      deliveryAgent: json['deliveryAgent'] != null
          ? DeliveryAgent.fromJson(json['deliveryAgent'])
          : null,
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shipmentsCount': shipmentsCount,
      'pickedShipments': pickedShipments,
      'vehicleType': vehicleType,
      'notes': notes,
      'status': status,
      'date': date,
      'customer': customer?.toJson(),
      'deliveryAgent': deliveryAgent?.toJson()
    };
  }
}
