import 'package:delivery_agent_app/models/Item.dart';
import 'package:delivery_agent_app/models/Receiver.dart';
import 'package:delivery_agent_app/models/User.dart';

class Shipment {
  final int? id;
  final double? price;
  final String? status;
  final Receiver? receiver;
  final Item? item;
  final User? user;
  final String? service;
  final String? shipmentConstrains;

  Shipment({
    required this.id,
    required this.item,
    required this.price,
    required this.receiver,
    required this.status,
    required this.user,
    required this.service,
    this.shipmentConstrains,
  });

  factory Shipment.fromJson(json) {
    return Shipment(
      id: json['id'],
      item: json['item'],
      price: json['price'],
      status: json['status'],
      receiver: json['receiver'],
      user: json['user'],
      service: json['service'],
      shipmentConstrains: json['shipmentConstrains'],
    );
  }
}
