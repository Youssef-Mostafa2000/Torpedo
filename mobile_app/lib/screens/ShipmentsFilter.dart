import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:mobile_app/widgets/Button.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/CustomSelectionMenu.dart';
import 'package:mobile_app/widgets/DatePicker.dart';
import 'package:mobile_app/widgets/SelectionMenu.dart';

class ShipmentsFilterScreen extends StatefulWidget {
  const ShipmentsFilterScreen({super.key});

  @override
  State<ShipmentsFilterScreen> createState() => _ShipmentsFilterScreenState();
}

class _ShipmentsFilterScreenState extends State<ShipmentsFilterScreen> {
  late String cityCurrentChoice;
  late String statusCurrentChoice;
  final List<String> statusItems = [
    'جديد',
    'في المخزن',
    'قيد التوصيل',
    'تعذر التسليم',
    'إعادة التوصيل',
    'تم التسليم'
  ];
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();
  final List<String> cityItems = [
    'الإسكندرية',
    'الإسماعيلية',
    'اسوان',
    'اسيوط',
    'الأقصر',
    'البحر الأحمر',
    'البحيرة',
    'بني سويف',
    'بورسعيد',
    'جنوب سيناء',
    'الجيزة',
    'الدقهلية',
    'دمياط',
    'سوهاج',
    'السويس',
    'الشرقية',
    'شمال سيناء',
    'الغربية',
    'الفيوم',
    'القاهرة',
    'القليوبية',
    'قنا',
    'كفر الشيخ',
    'مطروح',
    'المنوفية',
    'المنيا',
    'الوادي الجديد',
  ];

  @override
  void initState() {
    // TODO: implement initState
    cityCurrentChoice = '';
    statusCurrentChoice = '';
    super.initState();
  }

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
            children: [
              const CustomAppBar(
                title: 'تصنيف',
              ),
              CustomSelectionMenu(
                items: statusItems,
                onChanged: (value) => setState(() {
                  statusCurrentChoice = value;
                }),
                selectedItem: statusCurrentChoice,
                hint: 'الحالة',
                label: 'الحالة',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomSelectionMenu(
                items: cityItems,
                onChanged: (value) => setState(() {
                  cityCurrentChoice = value;
                }),
                selectedItem: cityCurrentChoice,
                hint: 'المحافظة',
                label: 'المحافظة',
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 10),
                    child: Text(
                      'التاريخ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('من'),
                      const SizedBox(
                        width: 15,
                      ),
                      DatePicker(date: fromDate),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('الى'),
                      const SizedBox(
                        width: 20,
                      ),
                      DatePicker(date: toDate),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Button(
                text: 'حفظ',
                onPressed: () {
                  BlocProvider.of<ShipmentCubit>(context).searchShipments({
                    'id': '-',
                    'status': statusCurrentChoice,
                    'city': cityCurrentChoice,
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
