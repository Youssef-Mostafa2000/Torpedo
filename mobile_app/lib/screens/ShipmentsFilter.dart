import 'package:flutter/material.dart';
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
  final List<String> statusItems = ['Items1', 'Items2'];
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'جميع الطلبات',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              /* الحالة */
              /*SelectionMenu(
                hint: 'الحالة',
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  setState(() => currentChoice = value);
                },
                items: statusItems,
                currentChoice: currentChoice,
              ),*/
              CustomSelectionMenu(
                items: ['Items1', 'Items2'],
                onChanged: (value) => setState(() {
                  statusCurrentChoice = value;
                }),
                selectedItem: statusCurrentChoice,
                hint: 'الحالة',
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
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* من */
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text('من'),
                      const SizedBox(
                        width: 10,
                      ),
                      /*Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xffF4F4F4),
                            style: BorderStyle.solid,
                          ),
                          color: const Color(0xffF4F4F4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month),
                            Text(
                              '25-5-2024',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),*/
                      DatePicker(date: '25-5-2024'),
                    ],
                  ),
                  Row(),
                  /*DatePickerDialog(
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  ),*/
                  /*DropdownButton(
                    items: const [
                      DropdownMenuItem(child: Text('Item1')),
                    ],
                    onChanged: (val) {},
                  ),*/
                  /* الى */
                  DropdownButton(
                    items: const [
                      DropdownMenuItem(child: Text('Item1')),
                    ],
                    onChanged: (val) {},
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 30,
                  ),
                  child: Text(
                    'حفظ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
