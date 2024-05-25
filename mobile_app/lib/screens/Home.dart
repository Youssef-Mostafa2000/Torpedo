import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/widgets/Menu.dart';
import 'package:mobile_app/widgets/MenuItem.dart';
import 'package:mobile_app/widgets/ShipmentStatusList.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "يوسف";
    String balance = "1000";
    return Scaffold(
      body: SizedBox(
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                      image: AssetImage('assets/images/Torpedo Text.jpeg'),
                      width: 120,
                      height: 120,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'أهلا $name',
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
                            // color: Color.fromARGB(255, 218, 114, 73),
                            color: Color(0xffea8a4e),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {},
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
                      onPressed: () {},
                    ),
                    MenuItem(
                      name: 'تتبع الشحنة',
                      icon: Icons.local_shipping_outlined,
                      onPressed: () {},
                    ),
                    MenuItem(
                      name: 'البحث والإستعلام',
                      icon: Icons.search_outlined,
                      onPressed: () {},
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
                      onPressed: () {},
                    ),
                    MenuItem(
                      name: 'البحث والإستعلام',
                      icon: Icons.search_outlined,
                      onPressed: () {},
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
