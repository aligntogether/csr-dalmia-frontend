import 'package:get/get.dart';

class AmountUtilizedController extends GetxController {


  List<Map<String, Map<String, dynamic>>>? amountUtilizedMappedList;
  List<String> rhlocationsList = [];


  List<String> columns = [
    'Budget Allocated',
    'Amount Utilized',
  ];

  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }


 Map<int,String>? regions;
  Map<String,List<String>>?locations;
  Map<String,dynamic>? data;
  void updateData(Map<String,dynamic> data){
    this.data=data;
    update(["add"]);
  }

void updateRegions(Map<int,String> regions){
  this.regions=regions;
  update(["add"]);
}
void updateLocations(Map<String,List<String>> locations){
  this.locations=locations;
  update(["add"]);
}

  var objectKeys = ["allocated", "utilized"];

  void updateAmountUtilizedMappedList(List<Map<String, Map<String, dynamic>>> amountUtilizedMappedList) {
    this.amountUtilizedMappedList = amountUtilizedMappedList;
    update(["add"]);
  }

  void updateRHLocationsList(List<String> rhlocationsList) {
    this.rhlocationsList = rhlocationsList;
    update(["add"]);
  }


}
