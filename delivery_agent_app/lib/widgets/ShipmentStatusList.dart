import 'package:delivery_agent_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:delivery_agent_app/models/Shipment.dart';
import 'package:delivery_agent_app/widgets/ShipmentsStatusCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentStatusList extends StatelessWidget {
  const ShipmentStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShipmentCubit, ShipmentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ShipmentsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ShipmentsLoaded) {
          List<Shipment> shipments = state.shipments!;
          int new_shipment = 0, waiting_shipment = 0, delivered_shipment = 0;
          for (Shipment shipment in shipments) {
            if (shipment.status == 'new' || shipment.status == 'جديد')
              new_shipment++;
            else if (shipment.status == 'waiting' ||
                shipment.status == 'قيد الإنتظار')
              waiting_shipment++;
            else if (shipment.status == 'delivered' ||
                shipment.status == 'تم التسليم') delivered_shipment++;
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ShipmentsStatusCard(
                  //   color: Theme.of(context).primaryColor,
                  //   name: 'جديد',
                  //   number: new_shipment,
                  // ),
                  // ShipmentsStatusCard(
                  //   color: const Color(0xff13CE66),
                  //   name: 'جميع الطلبات',
                  //   number: shipments.length,
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ShipmentsStatusCard(
                  //   color: const Color(0xffEA8A4E),
                  //   name: 'قيد الإنتظار',
                  //   number: waiting_shipment,
                  // ),
                  // ShipmentsStatusCard(
                  //   color: const Color(0xff2D8EFF),
                  //   name: 'تم التسليم',
                  //   number: delivered_shipment,
                  // ),
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      // child: ,
    );
  }
}
