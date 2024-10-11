import 'package:delivery_agent_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:delivery_agent_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:delivery_agent_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:delivery_agent_app/models/DeliveryAgent.dart';
import 'package:delivery_agent_app/models/Pickup.dart';
import 'package:delivery_agent_app/models/Shipment.dart';
import 'package:delivery_agent_app/screens/Login.dart';
import 'package:delivery_agent_app/screens/Shipments.dart';
import 'package:delivery_agent_app/services/AuthService.dart';
import 'package:delivery_agent_app/widgets/ShipmentStatusList.dart';
import 'package:delivery_agent_app/widgets/ShipmentsStatusCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'Settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<Shipment> shipments = [];
  List<Pickup> pickups = [];

  void load() async {
    setState(() {
      isLoading = true;
    });
    await BlocProvider.of<ShipmentCubit>(context)
        .getShipmentsByDeliveryAgentId();
    await BlocProvider.of<PickupCubit>(context).getPickupsByDeliveryAgentId();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkLoginStatus();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoginSuccess) {
            final DeliveryAgent deliveryAgent = state.deliveryAgent!;
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: Column(
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/Torpedo Text.jpeg'),
                          width: 120,
                          height: 120,
                        ),
                        IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ));
                          },
                          icon: Icon(
                            Icons.settings,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          '${deliveryAgent.name} أهلا',
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            'نظرة سريعة على الطلبات',
                            style: TextStyle(
                              fontSize: 26,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ShipmentsStatusCard(
                      id: 1,
                      color: Colors.green,
                      name: 'الأوردرات الحالية',
                      number: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ShipmentsStatusCard(
                      id: 2,
                      color: Colors.orange,
                      name: 'طلبات البيك أب الحالية',
                      number: 10,
                    ),
                  ],
                ),
              ),
            );
          }
          print(state);
          return Container(
            child: Text('Login Required'),
          );
        },
      ),
    );
  }
}
