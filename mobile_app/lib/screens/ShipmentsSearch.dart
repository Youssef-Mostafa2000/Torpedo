import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:mobile_app/models/Shipment.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/SearchField.dart';
import 'package:mobile_app/widgets/ShipmentCard.dart';

class ShipmentsSearch extends StatefulWidget {
  const ShipmentsSearch({super.key});

  @override
  State<ShipmentsSearch> createState() => _ShipmentsSearchState();
}

class _ShipmentsSearchState extends State<ShipmentsSearch> {
  TextEditingController _searchController = TextEditingController();
  List<Shipment> shipments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
        },
        builder: (context, state) {
          if (state is LoginSuccess) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomAppBar(
                      title: 'البحث',
                    ),
                    SearchField(
                      controller: _searchController,
                      onChanged: (val) {
                        BlocProvider.of<ShipmentCubit>(context)
                            .searchShipments({
                          'id': val,
                          'status': '',
                          'city': '',
                        });
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    BlocConsumer<ShipmentCubit, ShipmentState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ShipmentsInitial) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/magnifying glass.jpg'),
                                width: 220,
                                height: 220,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'ابحث عن طلبك وسيتم عرض النتائج هنا',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          );
                        } else if (state is ShipmentsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ShipmentsLoaded) {
                          shipments = state.shipments!;
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: shipments.length,
                              itemBuilder: (context, index) => ShipmentCard(
                                id: shipments[index].id.toString(),
                                name: shipments[index].receiver!.name ?? '',
                                city: shipments[index].receiver!.city ?? '',
                                district:
                                    shipments[index].receiver!.district ?? '',
                                phoneNumber:
                                    shipments[index].receiver!.phoneNumber ??
                                        '',
                                status: shipments[index].status ?? 'جديد',
                                date: shipments[index].date ?? DateTime.now(),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
