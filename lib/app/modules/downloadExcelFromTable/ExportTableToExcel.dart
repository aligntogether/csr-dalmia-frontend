import 'dart:io';

import 'package:dalmia/app/modules/addIntervention/controllers/add_intervention_controller.dart';
import 'package:dalmia/app/modules/amountUtilized/controllers/amount_utilized_controller.dart';
import 'package:dalmia/app/modules/expectedActual/controllers/expected_actual_controller.dart';
import 'package:dalmia/app/modules/leverWise/controllers/lever_wise_controller.dart';
import 'package:dalmia/app/modules/overviewPan/controllers/overview_pan_controller.dart';
import 'package:dalmia/app/modules/performanceVdf/controllers/performance_vdf_controller.dart';
import 'package:dalmia/app/modules/sourceFunds/controllers/source_funds_controller.dart';
import 'package:dalmia/pages/RH/rh_lever_wise_report/rh_lever_wise_report_controller.dart';
import 'package:excel/excel.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ExportTableToExcel {
  String formatNumber(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number);
  }
  String formatInLakhs(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number / 100000);
  }
  String deFormatNumber(String number) {
    return number.replaceAll(',', '');
  }

  Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');

        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory;
  }

  Future<void> exportTableToExcel(AddInterventionController controller,
      List<String> excelHeadings, List<String> dataRowHeadingKeys) async {
    // Get the table data as a list of lists
    List<List<String>> tableData = controller.interventionsData!
        .map((row) => [
              '${row[dataRowHeadingKeys[0]]}',
              '${row[dataRowHeadingKeys[1]]}',
              '${row[dataRowHeadingKeys[2]]}',
              '${row[dataRowHeadingKeys[3]]}',
            ])
        .toList();

    // Create an Excel workbook and worksheet
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Write the table data to the worksheet
    sheet.appendRow(excelHeadings);
    for (int i = 0; i < tableData.length; i++) {
      sheet.appendRow([i + 1, ...tableData[i]]);
    }

    // Generate a temporary path to save the Excel file
    final bytes = excel.save();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/interventions.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the Excel file
    await OpenFile.open(file.path);
  }

  Future<void> exportPanIndiaReportAllRegion(
      OverviewPanController controller,String location) async {
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];
    print("location $location");
   if(location=="All Regions"){
     print("location $location");
     List<String> headings = [];
     for(var region in controller.regionLocation!.keys){
       for(var location in controller.regionLocation![region]!){
         headings.add(location);
       }
       headings.add(region);
     }
     headings.add("Cement");

     headings.add("Pan India");
     // add first (0,0)
     sheetObject
         .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
         .value = "Locations";
     for(int i=1;i<=headings.length;i++){
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
           .value=headings[i-1];
     }
     for(int i =1;i<=controller.locationsList.length;i++){
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
           .value=controller.locationsList[i-1];
     }
     for(int j=1;j<=controller.locationsList.length;j++){
       num sum=0;
       num total=0;
       num sugar=0;
       for(int i=1;i<headings.length;i++){

         if(headings[i-1]=="South and Chandrapur" || headings[i-1]=="North East" || headings[i-1]=="Sugar" || headings[i-1]=="East"){
           if(controller.locationsList[j-1]=="Total no. of HH" ||controller.locationsList[j-1]=="HH with Annual Addl. Income"||
               controller.locationsList[j-1]=="Interventions"||controller.locationsList[j-1]=="Households"){
             sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: j))
                 .value='';
           }
           else{
             sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: j))
                 .value=sum;
             if(headings[i-1]=="Sugar"){
               sugar=sum;
             }
             total+=sum;

             sum=0;
           }
         }else{

           if(controller.locationsList[j-1]=="Total no. of HH" ||controller.locationsList[j-1]=="HH with Annual Addl. Income"||
               controller.locationsList[j-1]=="Interventions"||controller.locationsList[j-1]=="Households"){
             sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: j))
                 .value='';
           }

           else{

             sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: j))
                 .value=controller.overviewMappedList![0][controller.objectKeys[j-1]]==null?0:
             controller.overviewMappedList![0][controller.objectKeys[j-1]]![headings[i-1]]==null?0:controller.overviewMappedList![0][controller.objectKeys[j-1]]![headings[i-1]];
             sum=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: j))[0]![0]+sum;
           }
         }


       }
       if(controller.locationsList[j-1]=="Total no. of HH" ||controller.locationsList[j-1]=="HH with Annual Addl. Income"||
           controller.locationsList[j-1]=="Interventions"||controller.locationsList[j-1]=="Households"){
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: j))
             .value='';
       }else{
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: j))
             .value=total;
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length-1,rowIndex: j))
             .value=total-sugar;
         total=0;
       }
     }
     for (int i = 1; i <= headings.length; i++) {
       num sum = 0;
       for (int j = 13; j <=controller.locationsList.length; j++) {
         List<List<dynamic>?> cellValues =
         sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: j));

         // Check if cellValues is not null and has a non-null numeric value
         if (cellValues != null &&
             cellValues.isNotEmpty &&
             cellValues[0] != null &&
             cellValues[0]![0] != null &&
             cellValues[0]![0] is num) {
           sum += cellValues[0]![0];
         }
       }
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: controller.locationsList.length ))
           .value = sum;
     }
     // Create folder if not exists
     final downloadFolderPath = await createDownloadFolder("dalmia_report");

     // Save Excel file
     final bytes = excel.save();
     final file = File('$downloadFolderPath/OverViewPanReport.xlsx');
     await file.writeAsBytes(bytes!);

     // Open the file
     await OpenFile.open(file.path);
   }
   if(location=="East"){
     List<String> headings=[];
     for(var region in controller.regionLocation!.keys){
       if(region=="East"){
         for(var location in controller.regionLocation![region]!){
           headings.add(location);
         }
          headings.add(region);
       }
     }
     // add first (0,0)
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Locations";
     // add first (0,....)
     for(int i=1;i<=headings.length;i++){
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
           .value=headings[i-1];
     }
      for(int i =1;i<=controller.locationsList.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
            .value=controller.locationsList[i-1];
      }
      // add data in (..,..)
      for(int row=2;row<controller.locationsList.length;row++){
        for(int col=1;col<headings.length;col++){
          if(row==5 ||row==12){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value='';
          }
          else {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            controller.overviewMappedList![0][controller.objectKeys[row - 1]] ==
                null ? 0 :
            controller.overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]] == null ? 0 : controller
                .overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]];
          }
          }
      }
      // add each row total in last column
      for(int i=2;i<=controller.locationsList.length;i++){
       if(i==5 ||i==12){
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
             .value='';
       }
       else{
          num sum=0;
          for(int j=1;j<headings.length;j++){
           if(sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0]!=null){
             sum+=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0];
           }
          }
          sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
              .value=sum;
        }
      }
      // add total in (...,headings.length)
      for (int i = 1; i <= headings.length; i++) {
        num sum = 0;
        for (int j = 13; j <=controller.locationsList.length; j++) {
          List<List<dynamic>?> cellValues =
          sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: j));

          // Check if cellValues is not null and has a non-null numeric value
          if (cellValues != null &&
              cellValues.isNotEmpty &&
              cellValues[0] != null &&
              cellValues[0]![0] != null &&
              cellValues[0]![0] is num) {
            sum += cellValues[0]![0];
          }
        }
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: controller.locationsList.length ))
            .value = sum;
      }



     // Create folder if not exists
     final downloadFolderPath = await createDownloadFolder("dalmia_report");

     // Save Excel file
     final bytes = excel.save();
     final file = File('$downloadFolderPath/${location}OverViewReport.xlsx');
     await file.writeAsBytes(bytes!);

     // Open the file
     await OpenFile.open(file.path);
   }
   if(location=="North East"){
     List<String> headings=[];
     for(var region in controller.regionLocation!.keys){
       if(region=="North East"){
         for(var location in controller.regionLocation![region]!){
           headings.add(location);
         }
          headings.add(region);
       }
     }
     // add first (0,0)
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Locations";
     // add first (0,....)
     for(int i=1;i<=headings.length;i++){
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
           .value=headings[i-1];
     }
      for(int i =1;i<=controller.locationsList.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
            .value=controller.locationsList[i-1];
      }
      // add data in (..,..)
      for(int row=2;row<controller.locationsList.length;row++){
        for(int col=1;col<headings.length;col++){
          if(row==5 ||row==12){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value='';
          }
          else {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            controller.overviewMappedList![0][controller.objectKeys[row - 1]] ==
                null ? 0 :
            controller.overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]] == null ? 0 : controller
                .overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]];
          }
          }
      }
      // add each row total in last column
      for(int i=2;i<=controller.locationsList.length;i++){
       if(i==5 ||i==12){
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
             .value='';
       }
       else{
          num sum=0;
          for(int j=1;j<headings.length;j++){
           if(sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0]!=null){
             sum+=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0];
           }
          }
          sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
              .value=sum;
        }
      }
      // add total in (...,headings.length)
      for (int i = 1; i <= headings.length; i++) {
        num sum = 0;
        for (int j = 13; j <=controller.locationsList.length; j++) {
          List<List<dynamic>?> cellValues =
          sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: j));

          // Check if cellValues is not null and has a non-null numeric value
          if (cellValues != null &&
              cellValues.isNotEmpty &&
              cellValues[0] != null &&
              cellValues[0]![0] != null &&
              cellValues[0]![0] is num) {
            sum += cellValues[0]![0];
          }
        }
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: controller.locationsList.length ))
            .value = sum;
      }



     // Create folder if not exists
     final downloadFolderPath = await createDownloadFolder("dalmia_report");

     // Save Excel file
     final bytes = excel.save();
     final file = File('$downloadFolderPath/${location}OverViewReport.xlsx');
     await file.writeAsBytes(bytes!);

     // Open the file
     await OpenFile.open(file.path);
   }
    if(location=="South and Chandrapur"){
     List<String> headings=[];
     for(var region in controller.regionLocation!.keys){
       if(region=="South and Chandrapur"){
         for(var location in controller.regionLocation![region]!){
           headings.add(location);
         }
          headings.add(region);
       }
     }
     // add first (0,0)
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Locations";
     // add first (0,....)
     for(int i=1;i<=headings.length;i++){
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
           .value=headings[i-1];
     }
      for(int i =1;i<=controller.locationsList.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
            .value=controller.locationsList[i-1];
      }
      // add data in (..,..)
      for(int row=2;row<controller.locationsList.length;row++){
        for(int col=1;col<headings.length;col++){
          if(row==5 ||row==12){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value='';
          }
          else {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            controller.overviewMappedList![0][controller.objectKeys[row - 1]] ==
                null ? 0 :
            controller.overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]] == null ? 0 : controller
                .overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]];
          }
          }
      }
      // add each row total in last column
      for(int i=2;i<=controller.locationsList.length;i++){
       if(i==5 ||i==12){
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
             .value='';
       }
       else{
          num sum=0;
          for(int j=1;j<headings.length;j++){
           if(sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0]!=null){
             sum+=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0];
           }
          }
          sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
              .value=sum;
        }
      }
      // add total in (...,headings.length)
      for (int i = 1; i <= headings.length; i++) {
        num sum = 0;
        for (int j = 13; j <=controller.locationsList.length; j++) {
          List<List<dynamic>?> cellValues =
          sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: j));

          // Check if cellValues is not null and has a non-null numeric value
          if (cellValues != null &&
              cellValues.isNotEmpty &&
              cellValues[0] != null &&
              cellValues[0]![0] != null &&
              cellValues[0]![0] is num) {
            sum += cellValues[0]![0];
          }
        }
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: controller.locationsList.length ))
            .value = sum;
      }



     // Create folder if not exists
     final downloadFolderPath = await createDownloadFolder("dalmia_report");

     // Save Excel file
     final bytes = excel.save();
     final file = File('$downloadFolderPath/${location}OverViewReport.xlsx');
     await file.writeAsBytes(bytes!);

     // Open the file
     await OpenFile.open(file.path);
   }
    if(location=="Sugar"){
     List<String> headings=[];
     for(var region in controller.regionLocation!.keys){
       if(region=="Sugar"){
         for(var location in controller.regionLocation![region]!){
           headings.add(location);
         }
          headings.add(region);
       }
     }
     // add first (0,0)
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Locations";
     // add first (0,....)
     for(int i=1;i<=headings.length;i++){
       sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
           .value=headings[i-1];
     }
      for(int i =1;i<=controller.locationsList.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
            .value=controller.locationsList[i-1];
      }
      // add data in (..,..)
      for(int row=2;row<controller.locationsList.length;row++){
        for(int col=1;col<headings.length;col++){
          if(row==5 ||row==12){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value='';
          }
          else {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            controller.overviewMappedList![0][controller.objectKeys[row - 1]] ==
                null ? 0 :
            controller.overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]] == null ? 0 : controller
                .overviewMappedList![0][controller.objectKeys[row -
                1]]![headings[col - 1]];
          }
          }
      }
      // add each row total in last column
      for(int i=2;i<=controller.locationsList.length;i++){
       if(i==5 ||i==12){
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
             .value='';
       }
       else{
          num sum=0;
          for(int j=1;j<headings.length;j++){
           if(sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0]!=null){
             sum+=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0];
           }
          }
          sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: headings.length,rowIndex: i))
              .value=sum;
        }
      }
      // add total in (...,headings.length)
      for (int i = 1; i <= headings.length; i++) {
        num sum = 0;
        for (int j = 13; j <=controller.locationsList.length; j++) {
          List<List<dynamic>?> cellValues =
          sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: j));

          // Check if cellValues is not null and has a non-null numeric value
          if (cellValues != null &&
              cellValues.isNotEmpty &&
              cellValues[0] != null &&
              cellValues[0]![0] != null &&
              cellValues[0]![0] is num) {
            sum += cellValues[0]![0];
          }
        }
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: controller.locationsList.length ))
            .value = sum;
      }



     // Create folder if not exists
     final downloadFolderPath = await createDownloadFolder("dalmia_report");

     // Save Excel file
     final bytes = excel.save();
     final file = File('$downloadFolderPath/${location}OverViewReport.xlsx');
     await file.writeAsBytes(bytes!);

     // Open the file
     await OpenFile.open(file.path);
   }
    }


  Future<void> exportExpectedAndAcutualIncomeToExcel(
      List<dynamic> headings, List<int> LL) async {
    // Create an Excel workbook and worksheet
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "locations";
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
        .value = "DPM";

    for (int row = 1; row <= headings.length; row++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = headings[row - 1];
    }

    for (int i = 0; i < LL.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = LL[i];
    }

    final bytes = excel.save();

    final downloadFilePath = await getDownloadPath();
    final file =
        File('${downloadFilePath?.path}/expected_and_actual_income.xlsx');
    await file.writeAsBytes(bytes!);
    await OpenFile.open(file.path);
  }

  Future<void> exportLeverWiseReport(LeverWiseController controller) async {
    // Get the table data as a list of lists
    List<Map<String, Map<String, dynamic>>> leverWiseApiReportList =
        controller.leverWiseApiReportList!;

    // Create an Excel workbook and worksheet
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "locations";

    int i=1;
    for(var region in controller.regionLocation!.keys){
      for(var location in controller.regionLocation![region]!){
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = location;
        i++;
      }
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = region;
      i++;
    }
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: i++, rowIndex: 0))
        .value = "Cement";
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        .value = "Pan India";




    // add value to the first column
    for (int i = 0; i < controller.levers.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.levers[i];
    }


    num total=  0;
    num sugar=0;
    for (int row = 1; row <= controller.levers.length; row++) {
      num total2=0;
      for (int col = 1; col <= i; col++) {
        for(var region in controller.regionLocation!.keys){
          num sum=0;
          for(var location in controller.regionLocation![region]!){
            sum+=leverWiseApiReportList[0]  [controller.levers[row - 1]]![location];
            sheetObject
                .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            leverWiseApiReportList[0]
            [controller.levers[row - 1]]![location];
            col++;
          }
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
              .value =
          sum;
          if(region=="Sugar"){
            sugar=sum;
          }
          total+=sum;

          col++;
        }
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: col++, rowIndex: row))
            .value =
            total-sugar;
        sugar=0;
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
            .value =
            total;
        total=0;

      }

    }



    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/leverWiseReport.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the file
    await OpenFile.open(file.path);
  }

  Future<void> exportRhLeverWiseReport(RhLeverWiseController controller,String region) async{
    // Create an Excel workbook and worksheet
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];


    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "Levers";
    // fill the first row with locations
    int i=1;
    for(var location in controller.rhLeverWiseReportByRegionId!.keys.toList()) {
      for (var lever in controller.rhLeverWiseReportByRegionId![location].keys
          .toList()) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
            .value = location.toString()+"\n"+lever.toString();
        i++;
      }
    }
    // fill the first column with levers
    for (int i = 0; i < controller.levers.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.levers[i];
    }

    // fill the data in the excel sheet
   for(int row=1;row<=controller.levers.length;row++){
     int col=1;
     for(var location in controller.rhLeverWiseReportByRegionId!.keys.toList()) {
       for (var lever in controller.rhLeverWiseReportByRegionId![location].keys
           .toList()) {
         sheetObject
             .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
             .value =controller.rhLeverWiseReportByRegionId![location][lever][controller.levers[row-1]].toString()=="null"?"0":controller.rhLeverWiseReportByRegionId![location][lever][controller.levers[row-1]].toString();
         col++;
       }
     }
    }



    // create download folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");
    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/$region+leverWiseReport.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the file
    await OpenFile.open(file.path);


  }
  Future<void> exportVdfPerformance(LeverWiseController controller) async {
    // Get the table data as a list of lists
    List<Map<String, Map<String, dynamic>>> leverWiseApiReportList =
        controller.leverWiseApiReportList!;

    // Create an Excel workbook and worksheet
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "locations";

    for (int col = 1; col <= controller.allLocations.length; col++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
          .value = controller.allLocations[col - 1];
    }

    // add value to the first column
    for (int i = 0; i < controller.levers.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.levers[i];
    }
    // Add data to the Excel sheet
    for (int row = 1; row <= controller.levers.length; row++) {
      for (int col = 1; col <= controller.allLocations.length; col++) {
        sheetObject
                .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            leverWiseApiReportList[0]
                [controller.levers[row - 1]]![controller.allLocations[col - 1]];
      }
    }

    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/leverWiseReport.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the file
    await OpenFile.open(file.path);
  }

  Future<void> exportSourceFundsReport(SourceFundsController controller) async {
    // Get the table data as a list of lists
    Map<String, Map<String, dynamic>> sourceOfFundsDataList =
        controller.sourceOfFundsData!;

    // print(sourceOfFundsDataList["South and Chandrapur"]!["noOfHouseholds"]);

    // Create an Excel workbook and worksheet
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "locations";

    for (int col = 1; col <= controller.header.length; col++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
          .value = controller.header[col - 1];
    }

    // add value to the first column
    for (int i = 0; i < controller.locations.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.locations[i];
    }
    // Add data to the Excel sheet
    num total = 0;
    for (int row = 1; row <= controller.locations.length; row++) {
      num sum=0;
      for (int col = 1; col <= controller.header.length; col++) {
        sum+= sourceOfFundsDataList[controller.locations[row - 1]]
        ?[controller.header[col - 1]] !=
            null
            ? sourceOfFundsDataList[controller.locations[row - 1]]![
        controller.header[col - 1]]
            : 0;
        if(col==controller.header.length) {
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
              .value = formatNumber(sum.toInt());
        }
        else{
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
              .value = sourceOfFundsDataList[controller.locations[row - 1]]
          ?[controller.header[col - 1]] !=
              null
              ? formatNumber(sourceOfFundsDataList[controller.locations[row - 1]]![
          controller.header[col - 1]])
              : 0;
        }
      }
      total+=sum;
    }


    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/sourceFundIntervention.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the file
    await OpenFile.open(file.path);
  }

  Future<void> exportLocationWisePerformanceToExcel(
      PerformanceVdfController controller) async {
    // Get the table data as a list of lists
    Map<String, dynamic> performanceReport = controller.performanceReport!;

    // print(sourceOfFundsDataList["South and Chandrapur"]!["noOfHouseholds"]);

    // Create an Excel workbook and worksheet
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "details";

    for (int col = 1; col <= controller.headerList!.length; col++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
          .value = controller.headerList![col - 1];
      print(controller.headerList![col - 1]);
    }

    // add value to the first column
    for (int i = 0; i < controller.details!.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.details![i];
    }

    for (int i = 0; i < controller.details!.length; i++) {
      for (int j = 0; j < controller.headerList!.length; j++) {
        sheetObject
            .cell(
                CellIndex.indexByColumnRow(columnIndex: j + 1, rowIndex: i + 1))
            .value = performanceReport[controller.headerList![j]]![
                    controller.details![i]] ==
                null
            ? "0"
            : performanceReport[controller.headerList![j]]![
                controller.details![i]];
      }
    }

    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/vdf_performance_report.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the file
    await OpenFile.open(file.path);
  }

  Future<void> exportAmountUtilizedToExcel(
      AmountUtilizedController controller) async {
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    // Add Locations to the first row
    int columnIndex = 0;
    sheetObject
        .cell(
            CellIndex.indexByColumnRow(columnIndex: columnIndex++, rowIndex: 0))
        .value = "Locations";

    for (var region in controller.locations!.keys) {
      for (var location in controller.locations![region]!) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(
                columnIndex: columnIndex++, rowIndex: 0))
            .value = location;
      }
      // Add an empty cell for the Region column if there are locations in the region
      if (controller.locations![region]!.isNotEmpty) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(
                columnIndex: columnIndex++, rowIndex: 0))
            .value = region;
      }
    }

    // Add values to the first column
    for (int i = 0; i < controller.columns!.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.columns![i];
    }

    // Add data values to the Excel sheet
    for (int i = 0; i < controller.columns!.length; i++) {
      columnIndex =
          1; // Start from the second column (after the 'Locations' column)
      num sum = 0;
      for (var region in controller.locations!.keys) {
        for (var location in controller.locations![region]!) {
          // Check if controller.data is not null and contains the key 'location'
          if (controller.data != null &&
              controller.data!.containsKey(location)) {
            sum += controller.data![location][controller.objectKeys[i]];
            sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: columnIndex++, rowIndex: i + 1))
                .value = controller.data![location][controller.objectKeys[i]];
          } else {
            sum += 0;
            // Handle the case where controller.data is null or does not contain the key 'location'
            sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: columnIndex++, rowIndex: i + 1))
                .value = '0'; // Or any default value you prefer
          }
        }
        // Check if controller.data is not null and contains the key 'region'
        if (controller.data != null && controller.data!.containsKey(region)) {
          sheetObject
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: columnIndex++, rowIndex: i + 1))
              .value = sum;
        } else {
          // Handle the case where controller.data is null or does not contain the key 'region'
          sheetObject
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: columnIndex++, rowIndex: i + 1))
              .value = sum; // Or any default value you prefer
        }
      }
    }

    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/amountUtilized.xlsx');
    await file.writeAsBytes(bytes!);
    await OpenFile.open(file.path);
  }

  Future<void> exportAmountUtilizedToExcel1(
      AmountUtilizedController controller) async {
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    // Add Locations to the first row
    int columnIndex = 0;
    sheetObject
        .cell(
            CellIndex.indexByColumnRow(columnIndex: columnIndex++, rowIndex: 0))
        .value = "Locations";

    for (var region in controller.locations!.keys) {
      for (var location in controller.locations![region]!) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(
                columnIndex: columnIndex++, rowIndex: 0))
            .value = location;
      }
      // Add an empty cell for the Region column if there are locations in the region
      if (controller.locations![region]!.isNotEmpty) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(
                columnIndex: columnIndex++, rowIndex: 0))
            .value = region;
      }
    }

    // Add values to the first column
    for (int i = 0; i < controller.columns!.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.columns![i];
    }

    // Add data values to the Excel sheet
    for (int i = 0; i < controller.columns!.length; i++) {
      columnIndex =
          1; // Start from the second column (after the 'Locations' column)
      num sum = 0;
      for (var region in controller.locations!.keys) {
        for (var location in controller.locations![region]!) {
          // Check if controller.data is not null and contains the key 'location'
          if (controller.data != null &&
              controller.data!.containsKey(location)) {
            sum += controller.data![location][controller.objectKeys[i]];
            sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: columnIndex++, rowIndex: i + 1))
                .value = controller.data![location][controller.objectKeys[i]];
          } else {
            sum += 0;
            // Handle the case where controller.data is null or does not contain the key 'location'
            sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: columnIndex++, rowIndex: i + 1))
                .value = '0'; // Or any default value you prefer
          }
        }
        // Check if controller.data is not null and contains the key 'region'
        if (controller.data != null && controller.data!.containsKey(region)) {
          sheetObject
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: columnIndex++, rowIndex: i + 1))
              .value = sum;
        } else {
          // Handle the case where controller.data is null or does not contain the key 'region'
          sheetObject
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: columnIndex++, rowIndex: i + 1))
              .value = sum; // Or any default value you prefer
        }
      }
    }

    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/gplAllRegionAmountUtilized.xlsx');
    await file.writeAsBytes(bytes!);
    await OpenFile.open(file.path);
  }


  Future<void> exportRegionSOF(SourceFundsController controller) async {
    print("resg${controller.regionWiseSourceOfFundsData}");
    print("reg${controller.regions}");
    print("regss${controller.header}");
    print(
        "reg${controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[0])}");

    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];
    print("fdd ${controller.selectLocation}");

    // add Details in (0,0)
    if(controller.selectRegion!=null && controller.selectLocation!=null){

      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Details";

      //add controller.header in (..,0)
      for (int col = 1; col <= controller.header.length; col++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
            .value = controller.header[col - 1];
      }
     // add controller.clusterList in (0,...)
      for(int i=0;i<controller.clustersList!.length;i++){
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i+1))
            .value = controller.clustersList![i];
      }
print("ppp ${controller.clustersList!}");

      for(int row=1;row<=controller.clustersList!.length;row++){
        for(int col=1;col<controller.header.length;col++){


          }
      }
      // add each row total in last column
      for(int i=2;i<=controller.clustersList!.length;i++){
          num sum=0;
          for(int j=1;j<=controller.header.length;j++){
            if(controller.header[j-1]=="Total"){

            }
           else{
              if(sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0]!=null){
             sum+=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: j,rowIndex: i))[0]![0];
           }

          sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: controller.header.length,rowIndex: i))
              .value=sum;

        }
      }
    }



      // Create folder if not exists

      final downloadFolderPath = await createDownloadFolder("dalmia_report");

      // Save Excel file
      final bytes = excel.save();
      final file = File(controller.selectRegion == 'All Region'
          ? '$downloadFolderPath/sourceFundRegion.xlsx'
          : '$downloadFolderPath/sourceFundRegion${controller.selectLocation}.xlsx');
      await file.writeAsBytes(bytes!);
      await OpenFile.open(file.path);



    }
    else{
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Details";

      //add controller.header in (..,0)
      for (int col = 1; col <= controller.header.length; col++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
            .value = controller.header[col - 1];
      }

      // add controller.regions in (0,..)
      for (int i = 0; i < controller.regions.length; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = controller.regions[i];
      }
      for (int row = 1; row <= controller.regions.length; row++) {
        num sum=0;
        for (int col = 1; col <= controller.header.length; col++) {
          if(col==controller.header.length){
            sheetObject
                .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value = formatNumber(sum.toInt());
          }
          else{
            sum+=((controller.regionWiseSourceOfFundsData != null &&
                controller.regionWiseSourceOfFundsData!
                    .containsKey(controller.regions[row - 1]))
                ? ((controller.regionWiseSourceOfFundsData![
            controller.regions[row - 1]]![controller.header[col - 1]] ??
                0))
                : 0);
            sheetObject
                .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value = (controller.regionWiseSourceOfFundsData != null &&
                controller.regionWiseSourceOfFundsData!
                    .containsKey(controller.regions[row - 1]))
                ? formatNumber((controller.regionWiseSourceOfFundsData![
            controller.regions[row - 1]]![controller.header[col - 1]] ??
                0))
                : 0;
          }
        }
      }

      // Create folder if not exists
      final downloadFolderPath = await createDownloadFolder("dalmia_report");

      // Save Excel file
      final bytes = excel.save();
      final file = File(controller.selectRegion == 'All Region'
          ? '$downloadFolderPath/sourceFundRegion.xlsx'
          : '$downloadFolderPath/sourceFundRegion${controller.selectRegion}.xlsx');
      await file.writeAsBytes(bytes!);
      await OpenFile.open(file.path);
    }
  }

  Future<void> exportLocationSOF(SourceFundsController controller) async {
    print("resg${controller.locationWiseSourceOfFundsData}");
    print("reg${controller.locations}");
    print("reg${controller.header}");
    print(
        "reg${controller.locationWiseSourceOfFundsData!.containsKey(controller.locations[0])}");

    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];

    // add Details in (0,0)
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "Details";

    for (int col = 1; col <= controller.header.length; col++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
          .value = controller.header[col - 1];
    }

    // add controller.clustersList in (0,..)
    for (int i = 0; i < controller.clustersList!.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.clustersList![i];
    }
    num total=0;

    for (int row = 1; row < controller.clustersList!.length; row++) {
      num sum=0;
      for (int col = 1; col <= controller.header.length; col++) {
        if(col==controller.header.length){
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
              .value = formatNumber(sum.toInt());
        }
        else{
          sum+=((controller.locationWiseSourceOfFundsData != null &&
              controller.locationWiseSourceOfFundsData!
                  .containsKey(controller.clustersList![row - 1]))
              ? ((controller.locationWiseSourceOfFundsData![
          controller.clustersList![row - 1]]![controller.header[col - 1]] ??
              0))
              : 0);
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
              .value = (controller.locationWiseSourceOfFundsData != null &&
              controller.locationWiseSourceOfFundsData!
                  .containsKey(controller.clustersList![row - 1]))
              ? formatNumber((controller.locationWiseSourceOfFundsData![
          controller.clustersList![row - 1]]![controller.header[col - 1]] ??
              0))
              : 0;
        }

      }
    }


    for (int col = 1; col <= controller.header.length; col++) {
      num sum = 0;
      for (int row = 1; row <= controller.clustersList!.length; row++) {
        var cellValue = sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))[0]![0];

        // Check if cellValue is a SharedString and try to convert it to a num if possible
        if (cellValue is SharedString) {
          try {
            cellValue = num.parse(deFormatNumber(cellValue.toString()));
            print(cellValue);
          } catch (e) {
            print("Error parsing cell value to num: $e");
            continue; // Skip this cell and move to the next iteration
          }
        }

        sum += cellValue==null?0:cellValue;
        if(row==controller.clustersList!.length){
          sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
              .value = formatNumber(sum.toInt());
          sum=0;
        }

      }
    }

    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File(controller.selectLocation == 'All Location'
        ? '$downloadFolderPath/sourceFundLocation.xlsx'
        : '$downloadFolderPath/sourceFundLocation${controller.selectLocation}.xlsx');
    await file.writeAsBytes(bytes!);
    await OpenFile.open(file.path);
  }

  Future<void> exportExpectedActual(ExpectedActualController controller,String location1) async{

    print("ssdds ${location1}");
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];
    if(location1==""){
      List<String> header=[];
      for(var region in controller.regionLocation!.keys){
        for(var location in controller.regionLocation![region]!){
          header.add(location);
        }
        header.add(region);
      }
      header.add("Cement");
      header.add("Pan India");

      // insert (0,0)
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Locations";
      // insert(0,....)
      for(int i=1;i<=header.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
            .value=header[i-1];
      }
      // insert data in (..,0)
      for(int i =1;i<=controller.clusterPropertyKeys!.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
            .value=controller.clusterPropertyKeys![i-1]=='clusterId'?'Cluster $i':controller.clusterPropertyKeys![i-1];
      }
      // insert data in (..,..)
      num sum =0;
      num total=0;
      num sugar=0;
      int i=0;
      for(int col=1;col<=header.length;col++) {
        for (int row = 2; row <= controller.clusterPropertyKeys!.length; row++) {
          if (controller.expectedActualReport![header[col - 1]] != null) {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            controller.expectedActualReport![header[col - 1]]![controller
                .clusterIdList![i]] == null
                ? 0 : controller.expectedActualReport![header[col -
                1]]![controller.clusterIdList![i]][controller
                .clusterPropertyKeys![row - 1]];
          }
          else {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value = 0;
          }

          if (row != 2 && (row - 2) % 8 == 0) {
            i++;
          }
        }
      }
      // insert each row total in last column
      int j=0;
      for(int row =2;row<=controller.clusterPropertyKeys!.length;row++){
        for(int col=1;col<=header.length;col++){
          if(header[col-1]=="South and Chandrapur" || header[col-1]=="Sugar" || header[col-1]=="East"|| header[col-1]=="North East"){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value=sum;
            if(header[col-1]=="Sugar"){
              sugar=sum;
            }
            total+=sum;
            sum=0;
          }
          else if (header[col-1]=="Cement"){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value=total-sugar;
            sugar=0;

          }
          else if(header[col-1]=="Pan India"){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value=total;
            total=0;
          }
          else{
            if(sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))[0]![0]!=null){
              sum+=sheetObject.selectRangeValues(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))[0]![0];
            }

          }

        }
      }

    }
    else{
      List<String> header=[];
      for(var region in controller.regionLocation!.keys){
        for(var location in controller.regionLocation![region]!){
         if(location==location1){
           header.add(location1);
         }
        }

      }


      // insert (0,0)
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "Locations";
      // insert(0,....)
      for(int i=1;i<=header.length;i++){
       if(header[i-1]=="$location1"){
         sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i,rowIndex: 0))
             .value=header[i-1];       }
      }
      // insert data in (..,0)
      for(int i =1;i<=controller.clusterPropertyKeys!.length;i++){
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i))
            .value=controller.clusterPropertyKeys![i-1]=='clusterId'?'Cluster $i':controller.clusterPropertyKeys![i-1];
      }
      // insert data in (..,..)

      int i=0;
      for(int col=1;col<=header.length;col++) {
        for (int row = 2; row <= controller.clusterPropertyKeys!.length; row++) {
          if (controller.expectedActualReport![header[col - 1]] != null) {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            controller.expectedActualReport![header[col - 1]]![controller
                .clusterIdList![i]] == null
                ? 0 : controller.expectedActualReport![header[col -
                1]]![controller.clusterIdList![i]][controller
                .clusterPropertyKeys![row - 1]];
          }
          else {
            sheetObject
                .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value = 0;
          }

          if (row != 2 && (row - 2) % 8 == 0) {
            i++;
          }
        }
      }
      // insert each row total in last column
      int j=0;
      for(int row =2;row<=controller.clusterPropertyKeys!.length;row++){
        for(int col=1;col<=header.length;col++){
          if(header[col-1]==location1){
            sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col,rowIndex: row))
                .value=controller.expectedActualReport![header[col - 1]]==null
                ?0
                : controller.expectedActualReport![header[col - 1]]![controller.clusterIdList![j]]==null
                ?0
                :controller.expectedActualReport![header[col - 1]]![controller.clusterIdList![j]][controller.clusterPropertyKeys![row-1]];

          }



      }
    }
    }


    // Create folder if not exists
    final downloadFolderPath = await createDownloadFolder("dalmia_report");

    // Save Excel file
    final bytes = excel.save();
    final file = File('$downloadFolderPath/ExpectedAct${location1}.xlsx');
    await file.writeAsBytes(bytes!);

    // Open the file
    await OpenFile.open(file.path);  }

  Future<String> createDownloadFolder(String folderName) async {
    final downloadDirectory = await getDownloadPath();
    final folderPath = '${downloadDirectory?.path}/$folderName';

    final folder = Directory(folderPath);
    if (!folder.existsSync()) {
      folder.createSync();
    }

    return folderPath;
  }
}
