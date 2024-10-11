import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/services/DeliveryAgentService.dart';
import 'package:dio/dio.dart';
import 'package:mobile_app/models/DeliveryAgent.dart';

class PickupCard extends StatefulWidget {
  final String? id;
  final String? status;
  final int? numberOfShipments;
  final String? vehicleType;
  final int? deliveryAgentId;
  final String? deliveryAgentName;
  final String? deliveryAgentPhoneNumber;
  final DateTime? date;

  const PickupCard({
    required this.id,
    required this.status,
    required this.numberOfShipments,
    required this.vehicleType,
    required this.deliveryAgentName,
    required this.deliveryAgentPhoneNumber,
    required this.date,
    this.deliveryAgentId,
  });

  @override
  State<PickupCard> createState() => _PickupCardState();
}

class _PickupCardState extends State<PickupCard> {
  bool isLoading = true;
  DeliveryAgent? deliveryAgent;

  void load() async {
    deliveryAgent = await DeliveryAgentService(Dio())
        .getDeliveryAgent(widget.deliveryAgentId);
    print(deliveryAgent!.name);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: const Color(0xffF4F4F4),
              ),
              width: 327,
              height: 169,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    // textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Colors.green,
                              ),
                              width: 70,
                              height: 30,
                              child: Center(
                                child: Text(
                                  widget.status!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(widget.id!),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        deliveryAgent!.name == ''
                            ? 'لم تعين إلى مندوب التوصيل'
                            : deliveryAgent!.name.toString(),
                        style: TextStyle(),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        deliveryAgent!.phoneNumber.toString() == ''
                            ? '0'
                            : deliveryAgent!.phoneNumber.toString(),
                        style: TextStyle(),
                        textDirection: TextDirection.rtl,
                      ),
                      /*Text(
                  city! + ' - ' + district!,
                  style: TextStyle(),
                  textDirection: TextDirection.rtl,
                ),*/
                      Text(
                        widget.date!.year.toString() +
                            '-' +
                            widget.date!.month.toString() +
                            '-' +
                            widget.date!.day.toString(),
                        style: TextStyle(),
                        textDirection: TextDirection.rtl,
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
