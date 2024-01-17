import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/LL/expectedActualReport/expected_actual_additional_income_controller.dart';
import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'expected_actual_additional_income_services.dart';

class ExpectedincomeLL extends StatefulWidget {
  final String? refId;
  const ExpectedincomeLL({Key? key, required this.refId}) : super(key: key);

  @override
  State<ExpectedincomeLL> createState() => _ExpectedincomeLLState();
}

class _ExpectedincomeLLState extends State<ExpectedincomeLL> {
  ExpectedActualAdditionaIncomeController controller =
  Get.put(ExpectedActualAdditionaIncomeController());
  ExpectedActualAdditionalIncomeServices services =
  new ExpectedActualAdditionalIncomeServices();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    updateLocationIdByLocationLeadId(widget.refId!);

    isLoading = true;
  }

  void updateLocationIdByLocationLeadId(String refId) async {
    String locationId = await services.getLocationIdByLocationLeadId(refId);
    String locationName =
    await services.getLocationNameByLocationId(locationId);
    Map<String, dynamic> expectedActualAdditionalIncome =
     await services.getExpectedActualAdditionalIncome(locationId);
    List<String> clusterPropertyKeys = [];
    List<String> clusterId = [];
    setState(() {
      controller.updateLocationId(locationId);
      controller.updateLocationName(locationName);
      controller.updateExpectedActualAdditionalIncome(
          expectedActualAdditionalIncome);
      expectedActualAdditionalIncome.forEach((key, value) {
        clusterId.add(key);
        value.keys.forEach((element) {
          clusterPropertyKeys.add(element);
        });
      });
      controller.updateClusterId(clusterId);
      controller.updateClusterList(clusterPropertyKeys);
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
                        builder: (context) => const LLHome(),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetBuilder<ExpectedActualAdditionaIncomeController>(
                    builder: (cc) {
                      return !isLoading
                          ? Center(child: CircularProgressIndicator())
                          : eaaireport(0, cc);
                    },
                  ),
                ),
                Space.height(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eaaireport(int i, ExpectedActualAdditionaIncomeController cc) {
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
            DataColumn(
              label: Container(
                height: 60,
                width: 80,
                color: Color(0xff008CD3),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "${cc.locationName}",
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
                DataCell(
                  Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        "${cc.expectedActualAdditionalIncome![cc.clusterId![i]]![cc.clusterPropertyKeys![index]]}",
                        style: AppStyle.textStyleInterMed(fontSize: 14),
                      ),

                    ),
                    color: cc.clusterPropertyKeys![index] == "clusterId"
                        ? Color(0x806699CC)
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
