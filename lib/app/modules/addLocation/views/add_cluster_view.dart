import 'package:dalmia/app/modules/addLocation/controllers/add_location_controller.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../addLocation/Service/apiService.dart';


class AddClusterViewL extends StatefulWidget {
  String? region, location;

  AddClusterViewL({super.key});

  @override
  _AddClusterViewLState createState() => _AddClusterViewLState();
}

class _AddClusterViewLState extends State<AddClusterViewL> {
  final ApiService apiService = ApiService();
  AddLocationController a = Get.put(AddLocationController());
  String? validationResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Location',
            style: AppStyle.textStyleInterMed(
                fontSize: 16, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          actions: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close)),
            Space.width(20)
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.height(35),
            holdings(),
            Space.height(23),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: GetBuilder<AddLocationController>(id: "cluster",builder: (controller) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 18.0, // Spacing between columns
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 3 / 1.2 // Spacing between rows
                    ),
                    itemCount: a.locationList.length,
                    // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {

                      return GestureDetector(
                        onTap: () {
                          a.selectedIndex = index;
                          print("a.selectedIndex : ${a.selectedIndex}");
                          a.update(["cluster"]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: a.selectedIndex == index
                                  ? Color(0xffF15A22):Colors.white,
                              border: Border.all(
                                  color:  Color(0xff181818).withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              a.locationList[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:a.selectedIndex ==index
                                      ? Colors.white: Color(0xff181818).withOpacity(0.8)),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },)
              ),
            ),
            Space.height(30),
            GetBuilder<AddLocationController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () async {

                    String message = await pushLocation();

                    if (message == "Data Added") {
                      print("message : $message");
                      showConfirmationDialog(context);
                    }
                    else {
                      setState(() {
                        validationResult = message;
                      });

                    }

                  },
                  child: commonButton(
                      title: "Done",
                      color: (controller.nameController.value.text.isNotEmpty && a.selectRegion != null)
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            ),

            // Display the error message with red color if there's an error
            if (validationResult != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  validationResult!,
                  style: TextStyle(color: Colors.red),
                ),
              ),

          ],
        ));
  }

  Future<String> pushLocation() async {
    // Your validation logic here
    // Example: Check if fields are not empty, perform API validation, etc.
    // Return true if validation passes, false otherwise

    print('performValidation ${a.nameController.value.text}');

    Future<String> message = apiService.addLocation(a.selectRegionId ?? 0, a.nameController.value.text ?? "", a.selectedIndex < 0 ? a.selectedIndex : 0);

    print('performValidation message : ${message.toString()}');
    return message;
  }




  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          alignment: Alignment.topCenter,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: MySize.size248,
            child: Column(
              children: [
                Space.height(14),

              Image.asset(ImageConstant.check_circle,height: 50,width: 50,),
                Space.height(30),

                SizedBox(
                  child: Text(
                      '${a.nameController.value.text} added\nsuccessfully!',textAlign: TextAlign.center,
                      style: AppStyle.textStyleInterMed(fontSize: 16)),
                ),
                Space.height(30),
                GestureDetector(
                  onTap: () {
                    Get.offAll(GPLHomeScreen());

                  },
                  child: Container(
                    height: 50,
                    width: 157,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff27528F)),
                    child: Center(
                      child: Text(
                        "Ok",
                        style: AppStyle.textStyleInterMed(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget holdings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Cluster",
            style: AppStyle.textStyleBoldMed(fontSize: 14),
          ),
          Space.height(10),
          Text(
            "How many Clusters do you wish to include in this location?",
            style: AppStyle.textStyleInterMed(
                fontSize: 14, color: Color(0xff181818)),
          ),
        ],
      ),
    );
  }
}
