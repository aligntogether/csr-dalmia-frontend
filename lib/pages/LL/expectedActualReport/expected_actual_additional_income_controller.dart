
import 'package:get/get.dart';

class ExpectedActualAdditionaIncomeController extends GetxController{
  RxBool openMenu = false.obs;
  String? locationId;
  String? locationLeadId;
  String? locationName;
  List<String>? clusterPropertyKeys;
  List<String>? clusterId;
  Map<String, dynamic>? expectedActualAdditionalIncome;

  void updateLocationId(String locationId){
    this.locationId = locationId;
    update(["add"]);
  }
  void updateLocationLeadId(String locationLeadId){
    this.locationLeadId = locationLeadId;
    update(["add"]);
  }
  void updateLocationName(String locationName){
    this.locationName = locationName;
    update(["add"]);
  }
  void updateClusterList(List<String> clusterList){
    this.clusterPropertyKeys = clusterList;
    update(["add"]);
  }
  void updateExpectedActualAdditionalIncome(Map<String, dynamic> expectedActualAdditionalIncome){
    this.expectedActualAdditionalIncome = expectedActualAdditionalIncome;
    update(["add"]);
  }
  void updateClusterId(List<String> clusterId){
    this.clusterId = clusterId;
    update(["add"]);
  }


}