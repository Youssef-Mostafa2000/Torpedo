import 'package:flutter/material.dart';

class ShipmentCard extends StatelessWidget {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? city;
  final String? district;
  final DateTime? date;
  final String? status;
  const ShipmentCard({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.district,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        width: 60,
                        height: 30,
                        child: Center(
                          child: Text(
                            status!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(id!),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  name!,
                  style: TextStyle(),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  phoneNumber!,
                  style: TextStyle(),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  city! + ' - ' + district!,
                  style: TextStyle(),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  date!.year.toString() +
                      '-' +
                      date!.month.toString() +
                      '-' +
                      date!.day.toString(),
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
