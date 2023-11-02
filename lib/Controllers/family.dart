import 'dart:convert';
import 'dart:io';

void appendFamilyDataToJsonFile(
    Map<String, dynamic> familyData, int memberNumber) {
  final file = File('form_data.json');
  if (file.existsSync()) {
    final jsonString = file.readAsStringSync();
    if (jsonString != null) {
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      if (jsonData.containsKey('household')) {
        final householdData = jsonData['household'] as Map<String, dynamic>;
        if (householdData.containsKey('members')) {
          final members = householdData['members'] as List<dynamic>;
          members.add(familyData);
          householdData['members'] = members;
        } else {
          householdData['members'] = [familyData];
        }
        jsonData['household'] = householdData;
      } else {
        final householdData = {
          'head': {},
          'members': [familyData]
        };
        jsonData['household'] = householdData;
      }
      file.writeAsStringSync(json.encode(jsonData));
    }
  }
}
