import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/models/User.dart';
import 'package:mobile_app/screens/CreatePickup.dart';
import 'package:mobile_app/screens/CreateShipment.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/screens/Pickups.dart';
import 'package:mobile_app/screens/PickupsSearch.dart';
import 'package:mobile_app/screens/Settings.dart';
import 'package:mobile_app/screens/Shipments.dart';
import 'package:mobile_app/screens/ShipmentsSearch.dart';
import 'package:mobile_app/screens/Wallet.dart';
import 'package:mobile_app/widgets/Menu.dart';
import 'package:mobile_app/widgets/MenuItem.dart';
import 'package:mobile_app/widgets/ShipmentStatusList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure that we are checking the login status in the cubit.
    BlocProvider.of<AuthCubit>(context).checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    String balance = "1000";
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
            final User user = state.user!;
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
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
                            image:
                                AssetImage('assets/images/Torpedo Text.jpeg'),
                            width: 120,
                            height: 120,
                          ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
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
                        children: [
                          Text(
                            'أهلا ${user.name}',
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
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFFFFF8F4), Color(0xFFC6E3FD)],
                          ),
                        ),
                        width: 327,
                        height: 119,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                          ),
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الرصيد الحالي',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$balance جنيه',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                                const Spacer(
                                  flex: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            GestureDetector(
                              child: const Text(
                                'عرض الكل',
                                style: TextStyle(
                                  color: Color(0xffea8a4e),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ShipmentsScreen(),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                      const ShipmentStatusList(),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'الشحنات',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Menu(
                        items: [
                          MenuItem(
                            name: 'طلب جديد',
                            icon: Icons.add,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateShipmentScreen(),
                                  ));
                            },
                          ),
                          MenuItem(
                            name: 'تتبع الشحنة',
                            icon: Icons.local_shipping_outlined,
                            onPressed: () {},
                          ),
                          MenuItem(
                            name: 'البحث والإستعلام',
                            icon: Icons.search_outlined,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ShipmentsSearch(),
                                  ));
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'طلبات الإلتقاط',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Menu(
                        items: [
                          MenuItem(
                            name: 'طلب جديد',
                            icon: Icons.add,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePickupScreen(),
                                  ));
                            },
                          ),
                          MenuItem(
                            name: 'عرض الكل',
                            icon: Icons.view_list_outlined,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PickupsScreen(),
                                  ));
                            },
                          ),
                          MenuItem(
                            name: 'البحث والإستعلام',
                            icon: Icons.search_outlined,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PickupsSearchScreen(),
                                  ));
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'التفاصيل المالية',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Menu(
                        items: [
                          MenuItem(
                            name: 'كشف حساب',
                            icon: Icons.wallet_outlined,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WalletScreen(),
                                  ));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));*/
            return const Center(
              child: Text('Login required'),
            );
          }
        },
      ),
    );
  }
}
