import 'package:delivery_agent_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:delivery_agent_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:delivery_agent_app/models/Pickup.dart';
import 'package:delivery_agent_app/screens/Pickups.dart';
import 'package:delivery_agent_app/screens/Shipments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentsStatusCard extends StatelessWidget {
  final int? id;
  final Color? color;
  final String? name;
  final int? number;
  ShipmentsStatusCard({
    required this.id,
    required this.color,
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (id) {
          case 1:
            BlocProvider.of<ShipmentCubit>(context)
                .getShipmentsByDeliveryAgentId();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShipmentsScreen(),
              ),
            );
            break;
          case 2:
            BlocProvider.of<PickupCubit>(context).getPickupsByDeliveryAgentId();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PickupsScreen(),
              ),
            );
            break;
          default:
            break;
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.152,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Padding(
              padding: const EdgeInsets.only(right: 0.0, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    name!,
                    style: TextStyle(
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
