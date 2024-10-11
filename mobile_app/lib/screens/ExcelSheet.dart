import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class ExcelSheetScreen extends StatefulWidget {
  const ExcelSheetScreen({super.key});

  @override
  State<ExcelSheetScreen> createState() => _ExcelSheetScreenState();
}

class _ExcelSheetScreenState extends State<ExcelSheetScreen> {
  Future<void> createExcel() async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('نوع الخدمة');
    sheet.getRangeByName('A1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('A1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('A1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('B1').setText('قيمة الطرد');
    sheet.getRangeByName('B1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('B1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('B1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('C1').setText('فتح الطرد');
    sheet.getRangeByName('C1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('C1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('C1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('D1').setText('عدد القطع');
    sheet.getRangeByName('D1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('D1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('D1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('E1').setText('وزن الطرد');
    sheet.getRangeByName('E1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('E1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('E1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('F1').setText('وصف الطرد');
    sheet.getRangeByName('F1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('F1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('F1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('G1').setText('الرقم المرجعي');
    sheet.getRangeByName('G1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('G1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('G1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('H1').setText('اسم المرسل إليه');
    sheet.getRangeByName('H1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('H1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('H1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('I1').setText('رقم الموبايل');
    sheet.getRangeByName('I1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('I1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('I1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('J1').setText('المحافظة');
    sheet.getRangeByName('J1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('J1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('J1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('K1').setText('المنطقة');
    sheet.getRangeByName('K1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('K1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('K1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('L1').setText('العنوان بالتفصيل');
    sheet.getRangeByName('L1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('L1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('L1').cellStyle.vAlign = xlsio.VAlignType.center;

    sheet.getRangeByName('M1').setText('ملحوظات');
    sheet.getRangeByName('M1').cellStyle.borders.all.lineStyle =
        xlsio.LineStyle.thick;
    sheet.getRangeByName('M1').cellStyle.hAlign = xlsio.HAlignType.center;
    sheet.getRangeByName('M1').cellStyle.vAlign = xlsio.VAlignType.center;

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/sheet.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
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
                title: 'اضافة طلبات من شيت',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: createExcel,
                child: Text('تصدير شيت'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
