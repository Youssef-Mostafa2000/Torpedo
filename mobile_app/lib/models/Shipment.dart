import 'package:mobile_app/models/Item.dart';
import 'package:mobile_app/models/Receiver.dart';
import 'package:mobile_app/models/User.dart';

class Shipment {
  final int? id;
  final double? price;
  final String? status;
  final Receiver? receiver;
  final Item? item;
  final User? user;
  final String? service;
  final String? shipmentConstrains;
  final DateTime? date;

  Shipment({
    required this.id,
    required this.item,
    required this.price,
    required this.receiver,
    required this.status,
    this.user,
    required this.service,
    this.shipmentConstrains,
    this.date,
  });

  factory Shipment.fromJson(json) {
    return Shipment(
      id: json['id'],
      item: json['item'] ?? null,
      price: json['price'] ?? 0,
      status: json['status'] ?? 'جديد',
      receiver: json['receiver'],
      user: json['user'] ?? null,
      service: json['service'] ?? '',
      shipmentConstrains: json['shipmentConstrains'] ?? '',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'])
          : DateTime.now(),
    );
  }
}
