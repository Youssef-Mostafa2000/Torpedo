import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/DeliveredShipmentsCard.dart';

class DeliveredShipmentsList extends StatelessWidget {
  const DeliveredShipmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          DeliveredShipmentsCard(
            id: 123456,
            price: 150,
            deliveryFee: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          DeliveredShipmentsCard(
            id: 123456,
            price: 150,
            deliveryFee: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          DeliveredShipmentsCard(
            id: 123456,
            price: 150,
            deliveryFee: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          DeliveredShipmentsCard(
            id: 123456,
            price: 150,
            deliveryFee: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          DeliveredShipmentsCard(
            id: 123456,
            price: 150,
            deliveryFee: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          DeliveredShipmentsCard(
            id: 123456,
            price: 150,
            deliveryFee: 50,
          ),
        ],
      ),
    );
  }
}
