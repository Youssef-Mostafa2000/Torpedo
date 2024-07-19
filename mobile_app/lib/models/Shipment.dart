import 'package:mobile_app/models/Customer.dart';
import 'package:mobile_app/models/DeliveryAgent.dart';
import 'package:mobile_app/models/Item.dart';
import 'package:mobile_app/models/Receiver.dart';
import 'package:mobile_app/models/User.dart';

class Shipment {
  final int? id;
  final double? price;
  final String? status;
  final Receiver? receiver;
  final Item? item;
  final Customer? customer;
  final int? customer_id;
  final DeliveryAgent? deliveryAgent;
  final int? deliveryAgent_id;
  final String? service;
  final String? shipmentConstrains;
  final DateTime? date;

  Shipment({
    required this.id,
    required this.item,
    required this.price,
    required this.receiver,
    required this.status,
    this.customer,
    required this.service,
    this.shipmentConstrains,
    this.date,
    this.customer_id,
    this.deliveryAgent,
    this.deliveryAgent_id,
  });

  factory Shipment.fromJson(json) {
    return Shipment(
      id: json['id'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      price: json['price'] ?? 0,
      status: json['status'] ?? 'جديد',
      deliveryAgent_id: json['deliveryAgentId'],
      receiver:
          json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null,
      customer_id: json['customerId'],
      service: json['service'] ?? '',
      shipmentConstrains: json['shipmentConstrains'] ?? '',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'])
          : DateTime.now(),
    );
  }
}
