import 'dart:io';

import 'package:dalmia/app/modules/addIntervention/controllers/add_intervention_controller.dart';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ExportTableToExcel {
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
}
