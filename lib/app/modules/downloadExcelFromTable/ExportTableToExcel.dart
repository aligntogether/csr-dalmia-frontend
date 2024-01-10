import 'dart:io';

import 'package:dalmia/app/modules/addIntervention/controllers/add_intervention_controller.dart';
import 'package:dalmia/app/modules/overviewPan/controllers/overview_pan_controller.dart';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ExportTableToExcel {
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
      OverviewPanController controller) async {
    // Get the table data as a list of lists
    List<Map<String, Map<String, dynamic>>> panIndiaMappedData =
        controller.overviewMappedList!;

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

    //add value to first column
    for (int i = 0; i < controller.locationsList.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = controller.locationsList[i];
    }
    // Add data to the Excel sheet
    for (int row = 1; row <= 3; row++) {
      for (int col = 1; col <= controller.allLocations.length; col++) {
        sheetObject
            .cell(
                CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1))
            .value = panIndiaMappedData[
                0]
            [controller.objectKeys[row - 1]]![controller.allLocations[col - 1]];
        ;
      }
    }

    for (int col = 1; col <= controller.allLocations.length; col++) {
      sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 6))
              .value =
          panIndiaMappedData[0]
              [controller.objectKeys[3]]![controller.allLocations[col - 1]];
      ;
    }
    for (int row = 7; row <= 11; row++) {
      for (int col = 1; col <= controller.allLocations.length; col++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
            .value = panIndiaMappedData[
                0]
            [controller.objectKeys[row - 3]]![controller.allLocations[col - 1]];
        ;
      }
    }
    for (int row = 13; row <= 19; row++) {
      for (int col = 1; col <= controller.allLocations.length; col++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
            .value = panIndiaMappedData![
                0]
            [controller.objectKeys[row - 4]]![controller.allLocations[col - 1]];
        ;
      }
    }

    final bytes = excel.save();

    final downloadFilePath = await getDownloadPath();
    final file = File('${downloadFilePath?.path}/gplPanIndiaReport.xlsx');
    await file.writeAsBytes(bytes!);
    await OpenFile.open(file.path);
  }
}
