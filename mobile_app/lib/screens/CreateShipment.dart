import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/screens/Home.dart';
import 'package:mobile_app/widgets/Button.dart';
import 'package:mobile_app/widgets/InputTextField.dart';
import 'package:mobile_app/widgets/SelectionMenu.dart';
import 'package:mobile_app/widgets/StepProgressView.dart';

class CreateShipmentScreen extends StatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  State<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends State<CreateShipmentScreen> {
  int _currentStep = 0;
  final List<String> titles = ['المرسل إليه', 'تفاصيل الطرد', 'بيانات الشحن'];

  nextStep() {
    if (_currentStep == 2)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    setState(() {
      if (_currentStep < 2) _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 20,
          ),
          child: Column(
            children: [
              StepProgressView(
                curStep: _currentStep,
                titles: titles,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                height: 30,
              ),
              _currentStep == 0
                  ? ShippingDetails(context, nextStep)
                  : _currentStep == 1
                      ? ShipmentDetails(context, nextStep)
                      : ReceiverDetails(context, nextStep)
            ],
          ),
        ),
      ),
    );
  }
}

Widget ShippingDetails(BuildContext context, onNext) {
  final _shipmentPrice = TextEditingController();
  return Expanded(
    child: ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              'نوع الخدمة',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SelectionMenu(
          hint: 'اختر نوع الخدمة',
          textDirection: TextDirection.rtl,
          onChanged: (val) {},
          items: const [
            'تسليم كامل للطرد',
            'تسليم جزء من الطرد',
            'طرد مقابل طرد',
            'استرجاع طرد',
            'تسليم اموال'
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _shipmentPrice,
          label: 'قيمة الطرد',
          hint: 'أدخل قيمة الطرد',
          prefixText: 'ج.م',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              'فتح الطرد',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        SelectionMenu(
          hint: 'فتح الطرد',
          textDirection: TextDirection.rtl,
          onChanged: (val) {},
          items: [
            'مسموح بفتح الطرد',
            'غير مسموح بفتح الطرد',
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Button(
          text: 'التالي',
          onPressed: onNext,
        ),
      ],
    ),
  );
}

Widget ShipmentDetails(BuildContext context, onNext) {
  final _itemsNumController = TextEditingController();
  final _shipmentWeightController = TextEditingController();
  final _shipmentLengthController = TextEditingController();
  final _shipmentWidthController = TextEditingController();
  final _shipmentHeightController = TextEditingController();
  // final _shipmentWeightController = TextEditingController();

  return Expanded(
    child: ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        InputTextField(
          controller: _itemsNumController,
          label: 'عدد القطع',
          hint: 'أدخل عدد القطع',
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _shipmentWeightController,
          label: 'وزن الطرد',
          hint: 'أدخل وزن الطرد',
          prefixText: 'كجم',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
              child: InputTextField(
                controller: _shipmentLengthController,
                label: 'الطول',
                hint: '',
                prefixText: 'سم',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
              child: InputTextField(
                controller: _shipmentWidthController,
                label: 'العرض',
                hint: '',
                prefixText: 'سم',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
              child: InputTextField(
                controller: _shipmentHeightController,
                label: 'الإرتفاع',
                hint: '',
                prefixText: 'سم',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _shipmentWeightController,
          label: 'وصف الطرد',
          hint: 'مواصفات الطرد',
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _shipmentWeightController,
          label: 'الرقم المرجعي',
          hint: '',
          prefixText: 'كجم',
        ),
        const SizedBox(
          height: 40,
        ),
        Button(
          text: 'التالي',
          onPressed: onNext,
        ),
      ],
    ),
  );
}

Widget ReceiverDetails(BuildContext context, onNext) {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _phoneNumberAdditionalController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressController = TextEditingController();

  return Expanded(
    child: ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        InputTextField(
          controller: _nameController,
          label: 'الإسم',
          hint: 'أدخل اسم المرسل إليه',
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _phoneNumberController,
          label: 'رقم الموبايل',
          hint: 'أدخل رقم المرسل إليه',
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _phoneNumberAdditionalController,
          label: 'رقم موبايل إضافي',
          hint: 'رقم إضافي للمرسل إليه ',
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'المحافظة',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                  SelectionMenu(
                    hint: 'اختر المحافظة',
                    textDirection: TextDirection.rtl,
                    onChanged: (val) {},
                    items: [],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: InputTextField(
                controller: _districtController,
                label: 'المنطقة / الحي',
                hint: 'أدخل المنطقة',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _addressController,
          label: 'العنوان بالتفصيل',
          hint: 'أدخل العنوان بالتفصيل',
        ),
        const SizedBox(
          height: 40,
        ),
        Button(
          text: 'التالي',
          onPressed: onNext,
        ),
      ],
    ),
  );
}
