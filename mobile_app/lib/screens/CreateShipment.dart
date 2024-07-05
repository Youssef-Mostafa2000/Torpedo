import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/screens/Home.dart';
import 'package:mobile_app/widgets/Button.dart';
import 'package:mobile_app/widgets/InputTextField.dart';
import 'package:mobile_app/widgets/SelectionMenu.dart';
import 'package:mobile_app/widgets/StepProgressView.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';

class CreateShipmentScreen extends StatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  State<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends State<CreateShipmentScreen> {
  int _currentStep = 0;
  final List<String> titles = ['المرسل إليه', 'تفاصيل الطرد', 'بيانات الشحن'];
  final List<String> cities = [
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

  // بيانات الشحن
  String service_type = '';
  double price = 0;
  bool? open_shipment = null;

  // تفاصيل الطرد
  /*int items_count = 1;
  double shipment_weight = 0;
  double shipment_length = 0;
  double shipment_width = 0;
  double shipment_height = 0;
  String shipment_description = '';
  String reference_number = '';*/

  final _itemsNumController = TextEditingController();
  final _shipmentWeightController = TextEditingController();
  final _shipmentLengthController = TextEditingController();
  final _shipmentWidthController = TextEditingController();
  final _shipmentHeightController = TextEditingController();
  final _shipmentDescriptionController = TextEditingController();
  final _shipmentReferenceNumberController = TextEditingController();

  // المرسل إليه
  String receiver_city = '';
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _phoneNumberAdditionalController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressController = TextEditingController();

  void nextStep() {
    if (_currentStep == 2) {
      // create shipment api
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }

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
            vertical: 50,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: 'شحنة جديدة',
                ),
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
      ),
    );
  }

  Widget ShippingDetails(BuildContext context, onNext) {
    final _shipmentPrice = TextEditingController();

    return Column(
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
          currentChoice: service_type,
          onChanged: (val) {
            setState(() {
              service_type = val;
            });
          },
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
          currentChoice: open_shipment == true
              ? 'مسموح بفتح الطرد'
              : open_shipment == false
                  ? 'غير مسموح بفتح الطرد'
                  : null,
          onChanged: (val) {
            setState(() {
              open_shipment = (val == 'مسموح بفتح الطرد');
            });
          },
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
    );
  }

  Widget ShipmentDetails(BuildContext context, onNext) {
    return Column(
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
          controller: _shipmentDescriptionController,
          label: 'وصف الطرد',
          hint: 'مواصفات الطرد',
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextField(
          controller: _shipmentReferenceNumberController,
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
    );
  }

  Widget ReceiverDetails(BuildContext context, onNext) {
    return Column(
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
                    currentChoice: receiver_city,
                    onChanged: (val) {
                      setState(() {
                        receiver_city = val;
                      });
                    },
                    items: cities,
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
    );
  }
}
