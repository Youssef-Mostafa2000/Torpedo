import 'package:delivery_agent_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:delivery_agent_app/models/Pickup.dart';
import 'package:delivery_agent_app/widgets/PickupsScreenStatusCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickupsScreenStatusList extends StatelessWidget {
  const PickupsScreenStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickupCubit, PickupState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PickupsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PickupsLoaded) {
          List<Pickup> pickups = state.pickups!;
          int new_pickups = 0, delivered_pickups = 0, canceled_pickups = 0;
          for (Pickup pickup in pickups) {
            if (pickup.status == 'جديد' || pickup.status == 'new')
              new_pickups++;
            else if (pickup.status == 'تم الإلتقاط' ||
                pickup.status == 'delivered')
              delivered_pickups++;
            else if (pickup.status == 'تم الإلغاء' ||
                pickup.status == 'canceled') canceled_pickups++;
          }
          return Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PickupsScreenStatusCard(
                    color: Theme.of(context).primaryColor,
                    name: 'جديد',
                    number: new_pickups,
                  ),
                  PickupsScreenStatusCard(
                    color: Colors.green,
                    name: 'تم الإلتقاط',
                    number: delivered_pickups,
                  ),
                  PickupsScreenStatusCard(
                    color: Colors.red,
                    name: 'تم الإلغاء',
                    number: canceled_pickups,
                  ),
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
