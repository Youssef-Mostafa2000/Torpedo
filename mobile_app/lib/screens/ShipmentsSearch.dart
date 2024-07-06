import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/SearchField.dart';

class ShipmentsSearch extends StatefulWidget {
  const ShipmentsSearch({super.key});

  @override
  State<ShipmentsSearch> createState() => _ShipmentsSearchState();
}

class _ShipmentsSearchState extends State<ShipmentsSearch> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
              ),
              const SizedBox(
                height: 100,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/images/magnifying glass.jpg'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
