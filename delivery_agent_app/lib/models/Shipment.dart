import 'package:delivery_agent_app/models/Customer.dart';
import 'package:delivery_agent_app/models/DeliveryAgent.dart';
import 'package:delivery_agent_app/models/Item.dart';
import 'package:delivery_agent_app/models/Receiver.dart';
import 'package:delivery_agent_app/models/User.dart';

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
      receiver:
          json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null,
      service: json['service'] ?? '',
      shipmentConstrains: json['shipmentConstrains'] ?? '',
      deliveryAgent_id: json['deliveryAgentId'],
      date: json['date'] != null
          ? DateTime.tryParse(json['date'])
          : DateTime.now(),
      customer_id: json['customer_id'],
    );
  }

  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item!.toJson(),
      'price': price ?? 0,
      'status': status ?? '',
      'receiver': receiver!.toJson(),
      'customer': user!.toJson(),
      'service': service ?? '',
      'shipmentConstrains': shipmentConstrains ?? '',
    };
  }*/
}
