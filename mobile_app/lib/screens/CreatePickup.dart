import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/Button.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/InputTextField.dart';
import 'package:mobile_app/widgets/SelectionMenu.dart';

class CreatePickupScreen extends StatefulWidget {
  const CreatePickupScreen({super.key});

  @override
  State<CreatePickupScreen> createState() => _CreatePickupScreenState();
}

class _CreatePickupScreenState extends State<CreatePickupScreen> {
  final pickupsNumController = TextEditingController();
  final pickupsNotesController = TextEditingController();
  String vehicleType = '';
  final List<String> vehicleTypes = [
    'موتوسيكل',
    'سيارة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'طلب التقاط جديد',
                ),
                InputTextField(
                  controller: pickupsNumController,
                  label: 'عدد الشحنات',
                  hint: 'أدخل عدد الشحنات',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'وسيلة النقل',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                SelectionMenu(
                  hint: 'اختر وسيلة النقل',
                  textDirection: TextDirection.rtl,
                  currentChoice: vehicleType,
                  onChanged: (val) {
                    setState(() {
                      vehicleType = val;
                    });
                  },
                  items: vehicleTypes,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                  controller: pickupsNotesController,
                  label: 'ملاحظات',
                  hint: '',
                ),
                const SizedBox(
                  height: 60,
                ),
                Button(
                  text: 'حفظ',
                  onPressed: () {
                    // create pickup
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
