import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:mobile_app/models/Shipment.dart';
import 'package:mobile_app/services/ShipmentsService.dart';
import 'package:mobile_app/widgets/ShipmentsScreenStatusCard.dart';
import 'package:dio/dio.dart';

class ShipmentsScreenStatusList extends StatefulWidget {
  ShipmentsScreenStatusList({super.key});

  @override
  State<ShipmentsScreenStatusList> createState() =>
      _ShipmentsScreenStatusListState();
}

class _ShipmentsScreenStatusListState extends State<ShipmentsScreenStatusList> {
  List<Shipment> shipments = [];

  bool isLoading = false;

  void load() async {
    setState(() {
      isLoading = true;
    });
    shipments = await ShipmentService(Dio()).getShipmentsByCustomerId();
    setState(() {
      isLoading = false;
    });
  }

  initState() {
    super.initState();
    load();
  }

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
          //List<Shipment> shipments = state.shipments!;
          int new_shipment = 0,
              in_stock = 0,
              waiting_for_delivery = 0,
              delivering = 0,
              delivered_shipments = 0,
              reshipping = 0,
              failed = 0;
          for (Shipment shipment in shipments) {
            if (shipment.status == 'failed' ||
                shipment.status == 'تعذر التسليم')
              failed++;
            else if (shipment.status == 'new' || shipment.status == 'جديد')
              new_shipment++;
            else if (shipment.status == 'in stock' ||
                shipment.status == 'في المخزن')
              in_stock++;
            else if (shipment.status == 'delivering' ||
                shipment.status == 'قيد التوصيل')
              delivering++;
            else if (shipment.status == 'reshipping' ||
                shipment.status == 'إعادة التوصيل')
              reshipping++;
            else if (shipment.status == 'delivered' ||
                shipment.status == 'تم التسليم') delivered_shipments++;
          }
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShipmentsScreenStatusCard(
                          color: Theme.of(context).primaryColor,
                          name: 'جديد',
                          number: new_shipment,
                        ),
                        ShipmentsScreenStatusCard(
                          color: const Color(0xffFFCC3D),
                          name: 'في المخزن',
                          number: in_stock,
                        ),
                        ShipmentsScreenStatusCard(
                          color: const Color(0xff13CE66),
                          name: 'تم التسليم',
                          number: delivered_shipments,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShipmentsScreenStatusCard(
                          color: const Color(0xffEA8A4E),
                          name: 'قيد التوصيل',
                          number: delivering,
                        ),
                        ShipmentsScreenStatusCard(
                          color: Colors.lightBlue,
                          name: 'إعادة التوصيل',
                          number: reshipping,
                        ),
                        ShipmentsScreenStatusCard(
                          color: Colors.red,
                          name: 'تعذر التسليم',
                          number: failed,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
