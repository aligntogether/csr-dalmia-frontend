import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/pages/RH/rhhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/expected_actual_controller.dart';
import '../services/expected_actual_service.dart';
class ExpectedActualView extends StatefulWidget {
  const ExpectedActualView({Key? key}) : super(key: key);
  @override
  State<ExpectedActualView> createState() => _ExpectedActualViewState();
}
class _ExpectedActualViewState extends State<ExpectedActualView> {
  ExpectedActualController controller = Get.put(ExpectedActualController());
  ExpectedActualServices services = ExpectedActualServices();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
   getExpectActualAdditionalIncome();
    isLoading = true;
  }
  void getExpectActualAdditionalIncome() async{
    Map<String, dynamic> expectedActualReport=await services.getExpectedActualIncomeReport();
    List<String> clusterIdList = [];
    Map<String, dynamic> clusterList = {};
    List<String> clusterPropertyKeys = [];
    expectedActualReport.forEach((key, value) {
      value.keys.forEach((element) {
        clusterIdList.add(element);
      });
      value.forEach((key, value) {
        clusterList[key] = value;
      });

    });
    clusterList.forEach((key, value) {
      value.keys.forEach((element) {
        clusterPropertyKeys.add(element);
      });
    });
    setState(() {
      controller.updateExpectedActualReport(expectedActualReport);
      controller.updateClusterIdList(clusterIdList);
      controller.updateClusterList(clusterList);
      controller.updateClusterPropertyKeys(clusterPropertyKeys);
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: LLAppBar(
            heading: 'Reports',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RHHome(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left_sharp,
                      ),
                      Text(
                        'Main Menu',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Expected and actual additional incomes',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
          GetBuilder<ExpectedActualController>(
                    builder: (cc) {
                      return isLoading
                          ? Center(child: CircularProgressIndicator())
                          : eaaireport(0, cc);
                    },
                  ),
                Space.height(30),
              ],
            ),
          ),
        ),
      ),
    );}
  Widget eaaireport(int i, ExpectedActualController cc) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DataTable(

          dividerThickness: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4),

              ),
            ],
          ),

          columnSpacing: 0,
          horizontalMargin: 0,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 60,
                width: 220,
                color: Color(0xff008CD3),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Details",
                    style: TextStyle(
                      fontWeight: CustomFontTheme.headingwt,
                      fontSize: CustomFontTheme.textSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            for(String location in cc.allLocations)
              DataColumn(
                label: Container(
                  height: 60,
                  width: 80,
                  color: location=="SOUTH"? Color(0xff096C9F):Color(0xff008CD3),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      "$location",
                      style: TextStyle(
                        fontWeight: CustomFontTheme.headingwt,
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
          rows: List<DataRow>.generate(
            cc.clusterPropertyKeys!.length,
                (index) => DataRow(
              color: MaterialStateColor.resolveWith(
                    (states) {
                  i = 0;
                  return Colors.white;
                },
              ),
              cells: [
                DataCell(
                  Container(
                    width: 220,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${cc.clusterPropertyKeys![index]}",
                      style: AppStyle.textStyleInterMed(fontSize: 14),
                    ),
                    color: cc.clusterPropertyKeys![index] == "clusterId"
                        ?Color(0x806699CC)
                        : null,
                  ),

                ),
                for(String location in cc.allLocations)
                     DataCell(
                    Container(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child:
                      location == "SOUTH"
                          ? Text("",style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white))
                          : location == 'NE'
                          ? Text("",style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white))
                          : location == 'EAST'
                          ? Text("",style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white))
                          : location == 'CEMENT'
                          ? Text("",style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white))
                          : location == 'SUGAR'
                          ? Text("",style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white))
                          : location == 'PANIND'
                          ? Text("",style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white),)
                          : Text(
                              cc.expectedActualReport!.containsKey(location)
                            ? "${cc.clusterList![cc.clusterIdList![i]]![cc.clusterPropertyKeys![index]]}" == "null"
                            ? "0"
                            : "${cc.clusterList![cc.clusterIdList![i]]![cc.clusterPropertyKeys![index]]}"
                            : "0",
                        style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.black),
                        ),




          color:location==('SOUTH')||location=='NE' || location=='EAST' || location=='CEMENT' || location=='SUGAR' || location=='PANIND'
          ?Color(0xff096C9F): cc.clusterPropertyKeys![index] == "clusterId"
                          ?Color(0x806699CC)
                          : null,

                    ),
                  ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
